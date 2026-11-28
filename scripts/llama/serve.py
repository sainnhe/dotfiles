#!/usr/bin/env python3

import argparse
import logging
import os
import platform
import re
import subprocess
import sys
from pathlib import Path


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


def get_cache_dir() -> Path:
    if platform.system() == "Darwin":
        return Path.home() / "Library/Caches/llama.cpp"
    return Path.home() / ".cache" / "llama.cpp"


def get_thread_num() -> int:
    if platform.system() == "Darwin":
        return int(
            subprocess.check_output(
                ["sysctl", "-n", "hw.perflevel0.logicalcpu"]
            ).strip()
        )
    return max(1, (os.cpu_count() or 2) // 2)


def get_vram_mib() -> int:
    try:
        out = subprocess.check_output(
            ["nvidia-smi", "--query-gpu=memory.total", "--format=csv,noheader,nounits"],
            stderr=subprocess.DEVNULL,
            text=True,
        )
        return int(out.strip().splitlines()[0])
    except Exception:
        return 0


def get_avail_ram_mib() -> int:
    try:
        meminfo = {}
        with open("/proc/meminfo", "r") as f:
            for line in f:
                parts = line.split()
                if len(parts) >= 2:
                    meminfo[parts[0].rstrip(":")] = int(parts[1]) // 1024
        return meminfo.get("MemAvailable", meminfo.get("MemTotal", 32768))
    except Exception:
        return 32768


def download_model_if_not_exist(url: str, path: Path):
    if path.exists():
        return

    path.parent.mkdir(parents=True, exist_ok=True)
    logger.info(f"Downloading custom model to {path}...")
    part_path = path.with_suffix(".part")

    cmd = ["curl", "-fSL", "-C", "-", "-o", str(part_path), url]
    subprocess.run(cmd, check=True)
    part_path.rename(path)


def setup_huge_pages():
    if platform.system() != "Linux":
        return

    def get_current_setting(path):
        try:
            with open(path, "r") as f:
                match = re.search(r"\[(.*?)\]", f.read().strip())
                return match.group(1) if match else None
        except FileNotFoundError:
            return None

    enabled_path = "/sys/kernel/mm/transparent_hugepage/enabled"
    defrag_path = "/sys/kernel/mm/transparent_hugepage/defrag"

    current_enabled = get_current_setting(enabled_path)
    current_defrag = get_current_setting(defrag_path)

    enabled_ok = current_enabled in ["always", "madvise"]
    defrag_ok = current_defrag == "always"

    if enabled_ok and defrag_ok:
        logger.info(
            f"Huge Pages already optimized: enabled=[{current_enabled}], defrag=[{current_defrag}]"
        )
        return

    logger.warning("Huge Pages configuration needs update:")
    if not enabled_ok:
        logger.warning(
            f"'enabled' is currently [{current_enabled}], expected [madvise/always]"
        )
    if not defrag_ok:
        logger.warning(f"'defrag' is currently [{current_defrag}], expected [always]")

    logger.warning("Requesting sudo privileges to update kernel memory settings...")
    cmd = (
        "echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled && "
        "echo always | sudo tee /sys/kernel/mm/transparent_hugepage/defrag"
    )
    try:
        subprocess.run(cmd, shell=True, check=True, capture_output=True)
        logger.info("Linux performance optimization applied successfully!")
    except subprocess.CalledProcessError:
        logger.error(
            "Failed to update settings. Please check sudo permissions, or setup manually:"
        )
        print(cmd)


def needs_cpu_offload(flags, is_high_vram: bool) -> bool:
    if platform.system() != "Linux":
        return False
    if is_high_vram:
        return flags.ngl != -1
    conds = [
        flags.model == "inkling",
        flags.model == "qwen" and flags.task != "fim" and flags.perf != "low",
    ]
    return flags.ngl != -1 or any(conds)


def build_serve_cmd(flags, is_high_vram: bool, avail_ram_mib: int) -> list[str]:
    scale = {"low": 1, "medium": 2, "high": 4}[flags.perf]
    base_ctx = 8192 if flags.task == "fim" else 16384
    ctx_size = (
        int(flags.context_size * 1024)
        if flags.context_size is not None
        else base_ctx * scale
    )

    cpu_offload = needs_cpu_offload(flags, is_high_vram)
    cache_type_v = "q8_0"
    batch_size = "1024" if is_high_vram else "512"
    ubatch_size = "256" if is_high_vram else "128"

    if avail_ram_mib >= 48000:
        cache_ram = "16384"
        ctx_checkpoints = "32"
    elif cpu_offload:
        if ctx_size >= 65536:
            cache_ram = "2048"
            ctx_checkpoints = "8"
        else:
            cache_ram = "4096"
            ctx_checkpoints = "16"
    else:
        cache_ram = "8192"
        ctx_checkpoints = "16"

    # Model specific args
    model_args: list[str] = []
    if flags.model == "qwen":
        if flags.task == "fim":
            if flags.perf == "low":
                model_args = [
                    "--alias",
                    "Qwen/Qwen2.5-Coder-7B-Instruct",
                    "--hf-repo",
                    "unsloth/Qwen2.5-Coder-7B-Instruct-GGUF:Q4_K_M",
                    "--spec-type",
                    "ngram-mod",
                    "--spec-ngram-mod-n-match",
                    "16",
                    "--spec-ngram-mod-n-min",
                    "4",
                    "--spec-ngram-mod-n-max",
                    "64",
                    "--no-mmproj",
                ]
            elif flags.perf == "medium":
                model_args = [
                    "--alias",
                    "Qwen/Qwen2.5-Coder-14B-Instruct",
                    "--hf-repo",
                    "unsloth/Qwen2.5-Coder-14B-Instruct-GGUF:Q4_K_M",
                    "--spec-type",
                    "ngram-mod",
                    "--spec-ngram-mod-n-match",
                    "16",
                    "--spec-ngram-mod-n-min",
                    "4",
                    "--spec-ngram-mod-n-max",
                    "64",
                    "--no-mmproj",
                ]
            else:
                model_args = [
                    "--alias",
                    "Qwen/Qwen3-Coder-Next",
                    "--hf-repo",
                    "unsloth/Qwen3-Coder-Next-GGUF:UD-Q3_K_M",
                    "--spec-type",
                    "ngram-mod",
                    "--spec-ngram-mod-n-match",
                    "16",
                    "--spec-ngram-mod-n-min",
                    "4",
                    "--spec-ngram-mod-n-max",
                    "64",
                    "--no-mmproj",
                ]
        else:
            if flags.perf == "low":
                model_args = [
                    "--alias",
                    "Qwen/Qwen3.5-9B",
                    "--hf-repo",
                    "unsloth/Qwen3.5-9B-MTP-GGUF:UD-Q4_K_XL",
                    "--spec-type",
                    "ngram-mod,draft-mtp",
                    "--spec-draft-n-max",
                    "3",
                    "--spec-ngram-mod-n-match",
                    "16",
                    "--spec-ngram-mod-n-min",
                    "4",
                    "--spec-ngram-mod-n-max",
                    "64",
                    "--image-min-tokens",
                    "1024",
                ]
            elif not is_high_vram:
                if ctx_size >= 32768:
                    cache_type_v = "q4_0"
                model_args = [
                    "--alias",
                    "Qwen/Qwen3.8-27B",
                    "--hf-repo",
                    "unsloth/Qwen3.8-27B-GGUF:UD-IQ4_XS",
                    "--spec-type",
                    "ngram-mod,draft-mtp",
                    "--spec-draft-n-max",
                    "2",
                    "--spec-ngram-mod-n-match",
                    "16",
                    "--spec-ngram-mod-n-min",
                    "4",
                    "--spec-ngram-mod-n-max",
                    "64",
                    "--no-mmproj",
                    "--no-reasoning-preserve",
                    "--fit",
                    "off",
                    "-ot",
                    r"blk\.([7-9]|[1-5][0-9]|6[0-3])\.ffn_.*=CPU",
                ]
            else:
                model_args = [
                    "--alias",
                    "Qwen/Qwen3.8-27B",
                    "--hf-repo",
                    "unsloth/Qwen3.8-27B-GGUF:UD-IQ4_XS",
                    "--spec-type",
                    "ngram-mod,draft-mtp",
                    "--spec-draft-n-max",
                    "3",
                    "--spec-ngram-mod-n-match",
                    "16",
                    "--spec-ngram-mod-n-min",
                    "4",
                    "--spec-ngram-mod-n-max",
                    "64",
                    "--no-mmproj",
                ]
    elif flags.model == "seed":
        if flags.task == "fim":
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
                "--spec-default",
            ]
        elif flags.perf == "low":
            model_args = [
                "--alias",
                "ByteDance-Seed/Seed-Coder-8B-Reasoning",
                "--hf-repo",
                "unsloth/Seed-Coder-8B-Reasoning-GGUF:IQ4_NL",
                "--spec-default",
            ]
        elif flags.perf == "medium":
            model_args = [
                "--alias",
                "ByteDance-Seed/Seed-OSS-36B-Instruct",
                "--hf-repo",
                "unsloth/Seed-OSS-36B-Instruct-GGUF:IQ4_NL",
                "--spec-default",
            ]
        else:
            model_args = [
                "--alias",
                "ByteDance-Seed/Seed-OSS-36B-Instruct",
                "--hf-repo",
                "unsloth/Seed-OSS-36B-Instruct-GGUF:UD-Q8_K_XL",
                "--spec-default",
            ]
    elif flags.model == "deepseek":
        if flags.task == "fim":
            model_args = [
                "--alias",
                "deepseek-ai/DeepSeek-Coder-V2-Lite-Base",
                "--hf-repo",
                "legraphista/DeepSeek-Coder-V2-Lite-Base-IMat-GGUF:IQ4_NL",
                "--spec-default",
            ]
        else:
            model_args = [
                "--alias",
                "deepseek-ai/DeepSeek-R1-0528-Qwen3-8B",
                "--hf-repo",
                "unsloth/DeepSeek-R1-0528-Qwen3-8B-GGUF:IQ4_NL",
                "--spec-default",
            ]
    elif flags.model == "glm":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            sys.exit(1)
        if flags.perf == "low":
            model_args = [
                "--alias",
                "Akicou/GLM-4.7-Flash-REAP-50",
                "--hf-repo",
                "Akicou/GLM-4.7-Flash-REAP-50-GGUF:Q4_K_M",
                "--spec-default",
            ]
        elif flags.perf == "medium":
            model_args = [
                "--alias",
                "zai-org/GLM-4.7-Flash",
                "--hf-repo",
                "unsloth/GLM-4.7-Flash-GGUF:IQ4_NL",
                "--spec-default",
            ]
        else:
            model_args = [
                "--alias",
                "zai-org/GLM-4.7-Flash",
                "--hf-repo",
                "unsloth/GLM-4.7-Flash-GGUF:Q8_K_XL",
                "--spec-default",
            ]
    elif flags.model == "gemma":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            sys.exit(1)
        if flags.perf == "low":
            model_args = [
                "--alias",
                "google/gemma-4-12B-it",
                "--hf-repo",
                "unsloth/gemma-4-12b-it-GGUF:UD-Q4_K_XL",
                "--spec-type",
                "ngram-mod,draft-mtp",
                "--spec-draft-n-max",
                "3",
                "--spec-ngram-mod-n-match",
                "16",
                "--spec-ngram-mod-n-min",
                "4",
                "--spec-ngram-mod-n-max",
                "64",
            ]
        elif flags.perf == "medium":
            model_args = [
                "--alias",
                "google/gemma-4-26B-A4B-it",
                "--hf-repo",
                "unsloth/gemma-4-26B-A4B-it-GGUF:UD-IQ4_NL",
                "--spec-type",
                "ngram-mod,draft-mtp",
                "--spec-draft-n-max",
                "3",
                "--spec-ngram-mod-n-match",
                "16",
                "--spec-ngram-mod-n-min",
                "4",
                "--spec-ngram-mod-n-max",
                "64",
            ]
        else:
            model_args = [
                "--alias",
                "google/gemma-4-31B-it",
                "--hf-repo",
                "unsloth/gemma-4-31B-it-GGUF:UD-Q4_K_XL",
                "--spec-type",
                "ngram-mod,draft-mtp",
                "--spec-draft-n-max",
                "3",
                "--spec-ngram-mod-n-match",
                "16",
                "--spec-ngram-mod-n-min",
                "4",
                "--spec-ngram-mod-n-max",
                "64",
            ]
    elif flags.model == "muse":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            sys.exit(1)
        model_args = [
            "--alias",
            "meta-models/Muse-Glimmer-30B",
            "--hf-repo",
            "unsloth/Muse-Glimmer-30B-GGUF:UD-Q4_K_XL",
            "--spec-default",
        ]
    elif flags.model == "nemotron":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            sys.exit(1)
        model_args = [
            "--alias",
            "nvidia/Nemotron-Cascade-2-30B-A3B",
            "--hf-repo",
            "bartowski/nvidia_Nemotron-Cascade-2-30B-A3B-GGUF:IQ4_XS",
            "--spec-default",
        ]
    elif flags.model == "gpt-oss":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            sys.exit(1)
        model_args = [
            "--alias",
            "openai/gpt-oss-20b",
            "--hf-repo",
            "unsloth/gpt-oss-20b-GGUF:Q4_K_M",
            "--spec-default",
        ]
    elif flags.model == "jb":
        if flags.task == "fim":
            model_args = [
                "--alias",
                "JetBrains/Mellum2-12B-A2.5B-Base",
                "--hf-repo",
                "mradermacher/Mellum2-12B-A2.5B-Base-i1-GGUF:IQ4_NL",
                "--spec-default",
            ]
        else:
            model_args = [
                "--alias",
                "JetBrains/Mellum2.1-12B-A2.5B-Thinking",
                "--hf-repo",
                "bartowski/Mellum2.1-12B-A2.5B-Thinking-GGUF:IQ4_NL",
                "--spec-default",
            ]
    elif flags.model == "inkling":
        if flags.task == "fim":
            logger.error("This model family is only supported in chat mode.")
            sys.exit(1)
        model_args = [
            "--alias",
            "thinkingmachines/Inkling-2-Mini",
            "--hf-repo",
            "unsloth/Inkling-2-Mini-GGUF:UD-IQ4_XS",
            "--hf-repo-draft",
            "unsloth/Inkling-2-Mini-GGUF:Q8_0",
            "--spec-type",
            "ngram-mod,draft-dspark",
            "--spec-draft-n-max",
            "3",
            "--spec-ngram-mod-n-match",
            "16",
            "--spec-ngram-mod-n-min",
            "8",
            "--spec-ngram-mod-n-max",
            "32",
        ]
        if not is_high_vram:
            batch_size = "256"
            if ctx_size >= 65536:
                cache_type_v = "q4_0"
                ubatch_size = "96"
            model_args.extend(
                [
                    "--spec-draft-type-k",
                    "q4_0",
                    "--spec-draft-type-v",
                    "q4_0",
                    "--spec-draft-n-ubatch",
                    "32",
                    "--spec-draft-ngl",
                    "all",
                    "--no-mmproj",
                    "--fit",
                    "off",
                    "-ot",
                    r"token_embd\.weight=CPU,blk\.([0-8]|1[5-9]|2[0-3])\.ffn_.*=CPU",
                    "--moe-cache-mib",
                    "0",
                    "--moe-cache-cpu-share",
                    "0.7",
                ]
            )

    common_args: list[str] = [
        "--host",
        "::",
        "--port",
        "8080" if flags.task == "fim" else "8081",
        "--ctx-size",
        str(ctx_size),
        "--cache-type-k",
        "q8_0",
        "--cache-type-v",
        cache_type_v,
        "--batch-size",
        batch_size,
        "--ubatch-size",
        ubatch_size,
        "--flash-attn",
        "on",
        "--kv-unified",
        "--n-gpu-layers",
        str(flags.ngl),
        "--parallel",
        str(flags.parallel),
        "--load-mode",
        "none",
        "--cache-ram",
        cache_ram,
        "--ctx-checkpoints",
        ctx_checkpoints,
        "--jinja",
    ]

    if flags.metrics:
        common_args.append("--metrics")

    if flags.perf == "low":
        common_args.extend(
            [
                "--temp",
                "0.7",
                "--top-k",
                "50",
                "--top-p",
                "0.95",
                "--min-p",
                "0.05",
                "--repeat-penalty",
                "1.05",
            ]
        )
    else:
        common_args.extend(
            [
                "--temp",
                "1.0",
                "--top-k",
                "20",
                "--top-p",
                "0.95",
                "--min-p",
                "0.0",
                "--repeat-penalty",
                "1.0",
            ]
        )

    serve_cmd = ["llama-server"] + common_args + model_args
    if cpu_offload:
        serve_cmd = ["taskset", "-c", "0-" + str(get_thread_num() - 1)] + serve_cmd

    return serve_cmd


def main():
    parser = argparse.ArgumentParser(description="llama.cpp server wrapper")
    parser.add_argument(
        "-p",
        "--perf",
        choices=["low", "medium", "high"],
        help="Performance mode",
        required=True,
    )
    parser.add_argument(
        "-t",
        "--task",
        choices=["fim", "chat"],
        help="Task",
        required=True,
    )
    parser.add_argument(
        "-m",
        "--model",
        choices=[
            "qwen",
            "seed",
            "deepseek",
            "glm",
            "gemma",
            "muse",
            "nemotron",
            "gpt-oss",
            "jb",
            "inkling",
        ],
        help="Model family",
        required=True,
    )
    parser.add_argument(
        "-n",
        "--ngl",
        type=int,
        default=-1,
        help="Number of layers to store in VRAM",
        required=False,
    )
    parser.add_argument(
        "-c",
        "--context-size",
        type=float,
        default=None,
        help="Override the default context size calculation in k tokens (e.g., 8 for 8k/8192)",
        required=False,
    )
    parser.add_argument(
        "-P",
        "--parallel",
        type=int,
        default=1,
        help="Number of server slots",
        required=False,
    )
    parser.add_argument(
        "--metrics",
        action="store_true",
        help="Enable Prometheus metrics endpoint",
        required=False,
    )

    flags = parser.parse_args()

    vram_mib = get_vram_mib()
    avail_ram_mib = get_avail_ram_mib()
    is_high_vram = (vram_mib >= 24000) if vram_mib > 0 else (flags.perf == "high")

    if needs_cpu_offload(flags, is_high_vram):
        setup_huge_pages()

    serve_cmd = build_serve_cmd(flags, is_high_vram, avail_ram_mib)
    print(serve_cmd, flush=True)

    os.execvp(serve_cmd[0], serve_cmd)


if __name__ == "__main__":
    main()
