#!/usr/bin/env python3

import argparse
import os
import platform
import subprocess
from pathlib import Path
import re
import resource


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
    print(f"📥 Downloading custom model to {path}...")
    part_path = path.with_suffix(".part")

    # Download using curl, supports resuming
    cmd = ["curl", "-fSL", "-C", "-", "-o", str(part_path), url]
    subprocess.run(cmd, check=True)  # Raise exception when failed
    part_path.rename(path)


# TODO: memlock doesn't seem to be working properly
def setup_memlock_limit():
    if platform.system() != "Linux":
        return

    print("🔐 Adjusting memory lock limits (ulimit -l)...")
    try:
        # Set both soft and hard limits to infinity
        limit = resource.RLIM_INFINITY
        resource.setrlimit(resource.RLIMIT_MEMLOCK, (limit, limit))
        print("✅ Memory lock limit set to UNLIMITED.")
    except (ValueError, PermissionError) as e:
        soft, hard = resource.getrlimit(resource.RLIMIT_MEMLOCK)
        print(f"⚠️  Could not set ulimit to unlimited: {e}")
        print(f"   Current limits: Soft={soft}, Hard={hard}")
        print(
            "   If --mlock fails, add '* soft memlock unlimited' to /etc/security/limits.conf"
        )


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
        print(
            f"✅ Huge Pages already optimized: enabled=[{current_enabled}], defrag=[{current_defrag}]"
        )
        return

    # Log specific missing requirements
    print("🔍 Huge Pages configuration needs update:")
    if not enabled_ok:
        print(
            f"   - 'enabled' is currently [{current_enabled}], expected [madvise/always]"
        )
    if not defrag_ok:
        print(f"   - 'defrag' is currently [{current_defrag}], expected [always]")

    print("🛠️  Requesting sudo privileges to update kernel memory settings...")

    # We use 'madvise' for enabled as it is safer for system-wide stability
    # while still allowing llama.cpp (which calls madvise) to use Huge Pages.
    cmd = (
        "echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled && "
        "echo always | sudo tee /sys/kernel/mm/transparent_hugepage/defrag"
    )

    try:
        # Run the command through shell to support the pipe and sudo tee
        subprocess.run(cmd, shell=True, check=True, capture_output=True)
        print("🚀 Linux performance optimization applied successfully!")
    except subprocess.CalledProcessError:
        print(
            "❌ Failed to update settings. Please check sudo permissions, or setup manually:"
        )
        print(cmd)


def build_serve_cmd(flags) -> list[str]:
    if flags.perf == "low":
        scale = 1
    elif flags.perf == "medium":
        scale = 2
    else:
        scale = 4
    threads = get_thread_num()

    # Build common args
    comm_args: list[str] = [
        "--host",
        "::",
        "--port",
        "8080" if flags.mode == "fim" else "8081",
        "--ctx-size",
        str(8192 * scale),
        "--cache-type-k",
        "q8_0" if flags.perf != "high" else "f16",
        "--cache-type-v",
        "q8_0" if flags.perf != "high" else "f16",
        "--batch-size",
        str(max(4096, 2048 * scale)),
        "--ubatch-size",
        str(max(1024, 512 * scale)),
        "--cache-reuse",
        str(512 * scale),
        "--temp",
        "0.15" if flags.mode == "fim" else "0.7",
        "--top-k",
        "40" if flags.mode == "fim" else "50",
        "--top-p",
        "0.9" if flags.mode == "fim" else "0.95",
        "--min-p",
        "0.05",
        "--repeat-penalty",
        "1.0" if flags.mode == "fim" else "1.05",
        "--flash-attn",
        "on",
        "--n-gpu-layers",
        "0" if flags.proc == "cpu" else "-1",
        "--threads",
        str(threads),
        "--mlock",
    ]

    # Model specific args
    model_args: list[str] = []
    if flags.model == "seed":
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
    elif flags.model == "deepseek":
        model_args = [
            "--alias",
            "deepseek-ai/DeepSeek-Coder-V2-Lite-Base",
            "--hf-repo",
            "legraphista/DeepSeek-Coder-V2-Lite-Base-IMat-GGUF:IQ4_NL",
        ]
    elif flags.model == "qwen":
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
                "cerebras/Qwen3-Coder-REAP-25B-A3B",
                "--hf-repo",
                "mradermacher/Qwen3-Coder-REAP-25B-A3B-i1-GGUF:Q4_K_M",
            ]
        else:
            model_args = [
                "--alias",
                "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                "--hf-repo",
                "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q8_K_XL",
            ]
    elif flags.model == "glm":
        # TODO: Remove unnecessary chat_template_kwargs
        # TODO: test with --jinja
        # TODO: Performance of REAP variant is very poor
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
                "cerebras/GLM-4.7-Flash-REAP-23B-A3B",
                "--hf-repo",
                "unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF:IQ4_NL",
            ]
        else:
            model_args = [
                "--alias",
                "zai-org/GLM-4.7-Flash",
                "--hf-repo",
                "unsloth/GLM-4.7-Flash-GGUF:Q8_K_XL",
            ]
        model_args.append("--chat-template-kwargs")
        model_args.append(
            '{"enable_thinking": false, "thinking": {"type": "disabled"}}'
        )

    serve_cmd = ["llama-server"] + comm_args + model_args
    if flags.proc == "cpu" and platform.system() == "Linux":
        serve_cmd = ["taskset", "-c", "0-" + str(threads - 1)] + serve_cmd

    return serve_cmd


def main():
    parser = argparse.ArgumentParser(description="llama.cpp server wrapper")
    parser.add_argument(
        "--proc",
        choices=["cpu", "gpu"],
        help="Processing unit to use",
        default="cpu",
        required=False,
    )
    parser.add_argument(
        "--perf",
        choices=["low", "medium", "high"],
        help="Performace mode",
        default="low",
        required=False,
    )
    parser.add_argument(
        "--mode",
        choices=["fim", "inst"],
        help="Serving mode",
        default="fim",
        required=False,
    )
    parser.add_argument(
        "--model",
        choices=["seed", "deepseek", "qwen", "glm"],
        help="Model family",
        required=True,
    )

    flags = parser.parse_args()

    if platform.system() == "Linux":
        setup_memlock_limit()
        if flags.proc == "cpu":
            setup_huge_pages()

    serve_cmd = build_serve_cmd(flags)
    print(serve_cmd)

    try:
        subprocess.run(serve_cmd)
    except KeyboardInterrupt:
        print("\n👋 Server stopped.")


if __name__ == "__main__":
    main()
