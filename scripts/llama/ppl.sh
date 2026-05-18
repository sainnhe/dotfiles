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

# 1. Kill all llama-server process
ps aux | grep 'llama-server --host' | grep -v grep | awk '{print $2}' | xargs -I{} kill {}

# 2. Run ppl.sh
"$HOME/.local/bin/llama-perplexity" \
    -hf unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-IQ4_NL \
    -f "$DATASET_PATH" \
    -ngl -1 &>"$LOG_PATH"
