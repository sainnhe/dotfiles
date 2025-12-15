#!/usr/bin/env bash

UNAME=$(uname)

_serve() {
    llama-server \
        --host :: \
        --port 8080 \
        -ngl -1 \
        -c 8192 \
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
        "$@"
}

if [ "${UNAME}" = "Linux" ]; then
    if [ "$1" = "deepseek" ]; then
        _serve -hf QuantFactory/DeepSeek-Coder-V2-Lite-Base-GGUF:Q4_K_S \
            -hfd unsloth/Qwen2.5-Coder-0.5B-Instruct-GGUF:Q8_0 \
            --draft 5
    elif [ "$1" = "qwen-14b" ]; then
        _serve -hf QuantFactory/Qwen2.5-Coder-14B-GGUF:Q4_K_M \
            -hfd unsloth/Qwen2.5-Coder-0.5B-Instruct-GGUF:Q8_0 \
            --draft 5
    elif [ "$1" = "qwen-7b" ]; then
        _serve -hf QuantFactory/Qwen2.5-Coder-7B-GGUF:Q4_K_M
    elif [ "$1" = "seed" ]; then
        _serve --spm-infill \
            -m ~/.cache/llama.cpp/custom/mradermacher_Seed-Coder-8B-Base-GGUF_Seed-Coder-8B-Base.Q4_K_M.edited.gguf
    elif [ -n "$1" ]; then
        _serve "$@"
    else
        echo "Usage: $0 [deepseek|qwen-14b|qwen-7b|seed|args]"
    fi
elif [ "${UNAME}" = "Darwin" ]; then
    if [ "$1" = "qwen3" ]; then
        _serve -hf unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M \
            -hfd unsloth/Qwen2.5-Coder-0.5B-Instruct-GGUF:Q8_0 \
            --draft 5
    elif [ "$1" = "qwen2.5-7b" ]; then
        _serve -hf QuantFactory/Qwen2.5-Coder-7B-GGUF:Q4_K_M
    elif [ "$1" = "seed" ]; then
        _serve --spm-infill \
            -m ~/Library/Caches/llama.cpp/custom/mradermacher_Seed-Coder-8B-Base-GGUF_Seed-Coder-8B-Base.Q4_K_M.edited.gguf
    elif [ -n "$1" ]; then
        _serve "$@"
    else
        echo "Usage: $0 [qwen3|qwen2.5-7b|seed|args]"
    fi
fi
