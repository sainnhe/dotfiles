#!/usr/bin/env python3

import argparse
import os
import platform
import subprocess
from pathlib import Path
import re
import resource
import logging
import sys


class ColoredFormatter(logging.Formatter):
    grey = "\x1b[38;20m"
    green = "\x1b[32;20m"
    yellow = "\x1b[33;20m"
    red = "\x1b[31;20m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"

    format_str = "%(asctime)s | %(levelname)-8s | %(message)s"

    FORMATS = {
        logging.DEBUG: grey + format_str + reset,
        logging.INFO: green + format_str + reset,
        logging.WARNING: yellow + format_str + reset,
        logging.ERROR: red + format_str + reset,
        logging.CRITICAL: bold_red + format_str + reset,
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt, datefmt="%H:%M:%S")
        return formatter.format(record)


def setup_logger():
    ch = logging.StreamHandler(sys.stdout)
    ch.setLevel(logging.DEBUG)
    ch.setFormatter(ColoredFormatter())
    logger = logging.getLogger("LlamaServe")
    logger.setLevel(logging.DEBUG)
    logger.addHandler(ch)
    return logger


logger = setup_logger()


def get_cache_dir():
    if platform.system() == "Darwin":
        return Path.home() / "Library/Caches/llama.cpp"
    return Path.home() / ".cache" / "llama.cpp"


def get_thread_num():
    if platform.system() == "Darwin":
        return int(
            subprocess.check_output(
                ["sysctl", "-n", "hw.perflevel0.logicalcpu"]
            ).strip()
        )
    else:
        return os.cpu_count() // 2


def download_model_if_not_exist(url, path):
    path = Path(path)
    if path.exists():
        return

    path.parent.mkdir(parents=True, exist_ok=True)
    logger.info(f"Downloading custom model to {path}...")
    part_path = path.with_suffix(".part")

    # Download using curl, supports resuming
    cmd = ["curl", "-fSL", "-C", "-", "-o", str(part_path), url]
    subprocess.run(cmd, check=True)  # Raise exception when failed
    part_path.rename(path)


def setup_memlock_limit():
    if platform.system() != "Linux":
        return

    logger.info("Adjusting memory lock limits (ulimit -l)...")
    try:
        # Set both soft and hard limits to infinity
        limit = resource.RLIM_INFINITY
        resource.setrlimit(resource.RLIMIT_MEMLOCK, (limit, limit))
        logger.info("Memory lock limit set to UNLIMITED.")
    except (ValueError, PermissionError) as e:
        soft, hard = resource.getrlimit(resource.RLIMIT_MEMLOCK)
        logger.error(f"Could not set ulimit to unlimited: {e}")
        logger.error(f"Current limits: Soft={soft}, Hard={hard}")
        logger.error("Add the following lines to /etc/security/limits.conf and reboot:")
        print("* soft memlock unlimited")
        print("* hard memlock unlimited")
        logger.error('You can verify ulimit via "ulimit -Hl"')


def setup_huge_pages():
    if platform.system() != "Linux":
        return

    def get_current_setting(path):
        try:
            with open(path, "r") as f:
                content = f.read().strip()
                match = re.search(r"\[(.*?)\]", content)
                return match.group(1) if match else None
        except FileNotFoundError:
            return None

    enabled_path = "/sys/kernel/mm/transparent_hugepage/enabled"
    defrag_path = "/sys/kernel/mm/transparent_hugepage/defrag"

    # Read current system states
    current_enabled = get_current_setting(enabled_path)
    current_defrag = get_current_setting(defrag_path)

    # Validation criteria:
    # 1. 'enabled' should be 'always' or 'madvise' (llama.cpp uses madvise internally)
    # 2. 'defrag' should be 'always' to prevent latency spikes during MoE inference
    enabled_ok = current_enabled in ["always", "madvise"]
    defrag_ok = current_defrag == "always"

    if enabled_ok and defrag_ok:
        logger.info(
            f"Huge Pages already optimized: enabled=[{current_enabled}], defrag=[{current_defrag}]"
        )
        return

    # Log specific missing requirements
    logger.warning("Huge Pages configuration needs update:")
    if not enabled_ok:
        logger.warning(
            f"'enabled' is currently [{current_enabled}], expected [madvise/always]"
        )
    if not defrag_ok:
        logger.warning(f"'defrag' is currently [{current_defrag}], expected [always]")

    logger.warning("Requesting sudo privileges to update kernel memory settings...")

    # We use 'madvise' for enabled as it is safer for system-wide stability
    # while still allowing llama.cpp (which calls madvise) to use Huge Pages.
    cmd = (
        "echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled && "
        "echo always | sudo tee /sys/kernel/mm/transparent_hugepage/defrag"
    )

    try:
        # Run the command through shell to support the pipe and sudo tee
        subprocess.run(cmd, shell=True, check=True, capture_output=True)
        logger.info("Linux performance optimization applied successfully!")
    except subprocess.CalledProcessError:
        logger.error(
            "Failed to update settings. Please check sudo permissions, or setup manually:"
        )
        print(cmd)


def build_serve_cmd(flags) -> list[str]:
    if flags.perf == "low":
        scale = 1
    elif flags.perf == "medium":
        scale = 2
    else:
        scale = 4
    if flags.task == "fim":
        base_ctx = 8192
    else:
        base_ctx = 16384
    threads = get_thread_num()

    # Build common args
    comm_args: list[str] = [
        "--host",
        "::",
        "--port",
        "8080" if flags.task == "fim" else "8081",
        "--ctx-size",
        str(base_ctx * scale),
        "--cache-type-k",
        "q8_0" if flags.perf != "high" else "f16",
        "--cache-type-v",
        "q8_0" if flags.perf != "high" else "f16",
        "--batch-size",
        "2048",
        "--ubatch-size",
        "512",
        "--cache-reuse",
        "512",
        "--temp",
        "0.15" if flags.task == "fim" else "0.7",
        "--top-k",
        "40" if flags.task == "fim" else "50",
        "--top-p",
        "0.9" if flags.task == "fim" else "0.95",
        "--min-p",
        "0.05",
        "--repeat-penalty",
        "1.0" if flags.task == "fim" else "1.05",
        "--flash-attn",
        "on",
        "--n-gpu-layers",
        flags.ngl,
        "--threads",
        str(threads),
        "--mlock",
    ]
    if flags.task == "chat":
        comm_args.append("--jinja")

    # Model specific args
    model_args: list[str] = []
    if flags.model == "qwen":
        if flags.task == "fim":
            if flags.perf == "low":
                model_args = [
                    "--alias",
                    "Qwen/Qwen2.5-Coder-7B",
                    "--hf-repo",
                    "mradermacher/Qwen2.5-Coder-7B-i1-GGUF:Q4_K_M",
                ]
            elif flags.perf == "medium":
                model_args = [
                    "--alias",
                    "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    "--hf-repo",
                    "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:IQ4_NL",
                ]
            else:
                model_args = [
                    "--alias",
                    "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    "--hf-repo",
                    "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q8_K_XL",
                ]
        else:
            if flags.perf == "low":
                model_args = [
                    "--alias",
                    "Qwen/Qwen3-8B",
                    "--hf-repo",
                    "unsloth/Qwen3-8B-GGUF:IQ4_NL",
                ]
            else:
                model_args = [
                    "--alias",
                    "Qwen/Qwen3-30B-A3B",
                    "--hf-repo",
                    "unsloth/Qwen3-30B-A3B-GGUF:IQ4_NL",
                ]
    elif flags.model == "seed":
        if flags.task == "fim":
            # Modified version of mradermacher/Seed-Coder-8B-Base-i1-GGUF
            # Ref: https://github.com/ggml-org/llama.cpp/issues/17900
            model_path = get_cache_dir() / "custom" / "Seed-Coder-8B-Base.gguf"
            download_model_if_not_exist(
                "https://ciscai-gguf-editor.hf.space/download/mradermacher/Seed-Coder-8B-Base-i1-GGUF/Seed-Coder-8B-Base.i1-IQ4_NL.gguf?add=%5B%22tokenizer.ggml.fim_mid_token_id%22,4,126%5D&add=%5B%22tokenizer.ggml.fim_pre_token_id%22,4,124%5D&add=%5B%22tokenizer.ggml.fim_suf_token_id%22,4,125%5D",
                model_path,
            )
            model_args = [
                "--alias",
                "ByteDance-Seed/Seed-Coder-8B-Base",
                "--model",
                str(model_path),
                "--spm-infill",
            ]
        else:
            if flags.perf == "low":
                model_args = [
                    "--alias",
                    "ByteDance-Seed/Seed-Coder-8B-Reasoning",
                    "--hf-repo",
                    "unsloth/Seed-Coder-8B-Reasoning-GGUF:IQ4_NL",
                ]
            else:
                model_args = [
                    "--alias",
                    "ByteDance-Seed/Seed-OSS-36B-Instruct",
                    "--hf-repo",
                    "unsloth/Seed-OSS-36B-Instruct-GGUF:IQ4_NL",
                ]
    elif flags.model == "deepseek":
        if flags.task == "fim":
            model_args = [
                "--alias",
                "deepseek-ai/DeepSeek-Coder-V2-Lite-Base",
                "--hf-repo",
                "legraphista/DeepSeek-Coder-V2-Lite-Base-IMat-GGUF:IQ4_NL",
            ]
        else:
            model_args = [
                "--alias",
                "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B",
                "--hf-repo",
                "unsloth/DeepSeek-R1-0528-Qwen3-8B-GGUF:IQ4_NL",
            ]
    elif flags.model == "glm":
        # TODO: FIM performance is very poor
        if flags.perf == "low":
            model_args = [
                "--alias",
                "Akicou/GLM-4.7-Flash-REAP-50",
                "--hf-repo",
                "Akicou/GLM-4.7-Flash-REAP-50-GGUF:Q4_K_M",
            ]
        elif flags.perf == "medium":
            model_args = [
                "--alias",
                "zai-org/GLM-4.7-Flash",
                "--hf-repo",
                "unsloth/GLM-4.7-Flash-GGUF:IQ4_NL",
            ]
        else:
            model_args = [
                "--alias",
                "zai-org/GLM-4.7-Flash",
                "--hf-repo",
                "unsloth/GLM-4.7-Flash-GGUF:Q8_K_XL",
            ]
    elif flags.model == "nemotron":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            exit(1)
        else:
            model_args = [
                "--alias",
                "nvidia/NVIDIA-Nemotron-3-Nano-30B-A3B-BF16",
                "--hf-repo",
                "unsloth/Nemotron-3-Nano-30B-A3B-GGUF:IQ4_NL",
            ]
    elif flags.model == "gpt-oss":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            exit(1)
        else:
            model_args = [
                "--alias",
                "openai/gpt-oss-20b",
                "--hf-repo",
                "unsloth/gpt-oss-20b-GGUF:Q4_K_M",
            ]

    serve_cmd = ["llama-server"] + comm_args + model_args
    if flags.ngl != "-1" and platform.system() == "Linux":
        serve_cmd = ["taskset", "-c", "0-" + str(threads - 1)] + serve_cmd

    return serve_cmd


def main():
    parser = argparse.ArgumentParser(description="llama.cpp server wrapper")
    parser.add_argument(
        "-n",
        "--ngl",
        help="Number of layers to store in VRAM",
        default="-1",
        required=False,
    )
    parser.add_argument(
        "-p",
        "--perf",
        choices=["low", "medium", "high"],
        help="Performace mode",
        default="low",
        required=False,
    )
    parser.add_argument(
        "-t",
        "--task",
        choices=["fim", "chat"],
        help="Task",
        default="fim",
        required=False,
    )
    parser.add_argument(
        "-m",
        "--model",
        choices=["qwen", "seed", "deepseek", "glm", "nemotron", "gpt-oss"],
        help="Model family",
        required=True,
    )

    flags = parser.parse_args()

    if flags.ngl != "-1" and platform.system() == "Linux":
        setup_memlock_limit()
        setup_huge_pages()

    serve_cmd = build_serve_cmd(flags)
    print(serve_cmd)

    try:
        subprocess.run(serve_cmd)
    except KeyboardInterrupt:
        print("\n👋 Server stopped.")


if __name__ == "__main__":
    main()
