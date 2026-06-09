#!/usr/bin/env bash

source "$HOME/.zsh_envs.d/cuda.zsh"
source "$HOME/.zsh_envs.d/llama.zsh"
LOG_DIR="$HOME/ppl/log"
DATASET_PATH="$HOME/ppl/codebase.raw"

# 0. Init
if [[ ! -f "$DATASET_PATH" ]]; then
    echo "$DATASET_PATH doesn't exist"
    exit 1
fi
mkdir -p "$LOG_DIR"
LOG_PATH="$LOG_DIR/$(date +%Y-%m-%dT%H:%M:%S%Z).log"

_kill_ps() {
    ps aux | grep 'llama-server --host' | grep -v grep | awk '{print $2}' | xargs -I{} kill {}
}

_run_ppl() {
    "$HOME/.local/bin/llama-perplexity" \
        -hf unsloth/Qwen3.5-9B-MTP-GGUF:UD-Q4_K_XL \
        -f "$DATASET_PATH" \
        -ngl -1 &>"$LOG_PATH"
}

# Try to run ppl without killing processes. Kill processes if failed.
_run_ppl || _kill_ps && _run_ppl
