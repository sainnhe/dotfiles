#!/usr/bin/env bash

UNAME=$(uname)

_serve() {
    llama-server \
        --host 0.0.0.0 \
        --port 8080 \
        -ngl 99 \
        -c 16384 \
        -ctk q8_0 \
        -ctv q8_0 \
        -b 2048 \
        -ub 512 \
        --temp 0.15 \
        --top-k 40 \
        --top-p 0.9 \
        --min-p 0.05 \
        --repeat-penalty 1.0 \
        -fa on \
        --cache-reuse 256 \
        -hf "$@"
}

if [ "${UNAME}" = "Linux" ]; then
    if [ "$1" = "deepseek" ]; then
        _serve QuantFactory/DeepSeek-Coder-V2-Lite-Base-GGUF:Q4_K_S
    elif [ "$1" = "qwen" ]; then
        _serve QuantFactory/Qwen2.5-Coder-14B-GGUF:Q4_K_M
    elif [ "$1" = "seed" ]; then
        _serve mradermacher/Seed-Coder-8B-Base-GGUF:Q4_K_M
    elif [ -n "$1" ]; then
        _serve "$@"
    else
        echo "Usage: $0 [deepseek|qwen|seed|hf_model]"
    fi
elif [ "${UNAME}" = "Darwin" ]; then
    if [ "$1" = "qwen" ]; then
        _serve \
            unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M \
            -hfd unsloth/Qwen2.5-Coder-0.5B-Instruct-GGUF:Q8_0
    elif [ "$1" = "seed" ]; then
        _serve mradermacher/Seed-Coder-8B-Base-GGUF:Q4_K_M
    elif [ -n "$1" ]; then
        _serve "$@"
    else
        echo "Usage: $0 [qwen|seed|hf_model]"
    fi
fi
