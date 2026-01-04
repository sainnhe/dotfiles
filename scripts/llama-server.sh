#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
    CACHE_DIR="$HOME/Library/Caches/llama.cpp"
else
    CACHE_DIR="$HOME/.cache/llama.cpp"
fi

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

if [ "$1" = "seed" ]; then
    _serve --spm-infill \
        -m "$CACHE_DIR/custom/mradermacher_Seed-Coder-8B-Base-GGUF_Seed-Coder-8B-Base.Q4_K_M.edited.gguf"
elif [ "$1" = "qwen-7b" ]; then
    _serve -hf QuantFactory/Qwen2.5-Coder-7B-GGUF:Q4_K_M
elif [ "$1" = "qwen-14b" ]; then
    _serve -hf QuantFactory/Qwen2.5-Coder-14B-GGUF:Q4_K_M
elif [ "$1" = "deepseek" ]; then
    _serve -hf QuantFactory/DeepSeek-Coder-V2-Lite-Base-GGUF:Q4_K_S
elif [ -n "$1" ]; then
    _serve "$@"
else
    echo "Usage: $0 {seed|qwen-7b|qwen-14b|deepseek|args...}"
fi
