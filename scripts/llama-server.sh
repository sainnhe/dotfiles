#!/usr/bin/env bash

_linux() {
    llama-server \
        --host 0.0.0.0 \
        --port 8080 \
        -ngl 99 \
        -c 16384 \
        -ctk q8_0 \
        -ctv q8_0 \
        -b 2048 \
        -hf "$1"
    echo "==> Endpoint: http://0.0.0.0:8080/infill"
}

if [ "$(uname)" = "Linux" ]; then
    if [ "$1" = "deepseek" ]; then
        _linux QuantFactory/DeepSeek-Coder-V2-Lite-Base-GGUF:Q4_K_S
    elif [ "$1" = "qwen" ]; then
        _linux QuantFactory/Qwen2.5-Coder-14B-GGUF:Q4_K_M
    elif [ -n "$1" ]; then
        _linux "$1"
    else
        echo "Usage: $0 [deepseek|qwen|hf_model]"
    fi
fi
