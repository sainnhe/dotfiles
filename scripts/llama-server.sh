#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
    CACHE_DIR="$HOME/Library/Caches/llama.cpp"
else
    CACHE_DIR="$HOME/.cache/llama.cpp"
fi

HELP_MSG="Usage: $0 {low|medium|high} {seed|deepseek|qwen|glm|args...}"

_serve() {
    local MODE=$1
    shift # 移除第一个参数，剩下的 $@ 将作为模型路径或其他参数传递

    # 默认值 (Low / 8k)
    local CONTEXT=8192
    local CTK="q8_0"
    local CTV="q8_0"
    local BATCH=2048
    local UBATCH=512
    local CACHE_REUSE=256

    case "$MODE" in
    low)
        CONTEXT=8192
        ;;
    medium)
        CONTEXT=16384
        BATCH=4096
        UBATCH=1024
        CACHE_REUSE=1024
        ;;
    high)
        CONTEXT=32768
        CTK=f16
        CTV=f16
        BATCH=4096
        UBATCH=1024
        CACHE_REUSE=2048
        ;;
    *)
        echo "$HELP_MSG"
        return 1
        ;;
    esac

    echo "🚀 Starting llama-server in [$MODE] mode..."
    echo "   Context: $CONTEXT | KV-Cache: $CTK | Batch: $BATCH"

    llama-server \
        --host :: \
        --port 8080 \
        -ngl -1 \
        -c "$CONTEXT" \
        -ctk "$CTK" \
        -ctv "$CTV" \
        -b "$BATCH" \
        -ub "$UBATCH" \
        --temp 0.15 \
        --top-k 40 \
        --top-p 0.9 \
        --min-p 0.05 \
        --repeat-penalty 1.0 \
        -fa on \
        --cache-reuse "$CACHE_REUSE" \
        "$@"
}

if [ "$2" = "seed" ]; then
    # Modified version of mradermacher/Seed-Coder-8B-Base-i1-GGUF
    # Ref: https://github.com/ggml-org/llama.cpp/issues/17900
    MODEL_URL='https://ciscai-gguf-editor.hf.space/download/mradermacher/Seed-Coder-8B-Base-i1-GGUF/Seed-Coder-8B-Base.i1-IQ4_NL.gguf?add=%5B%22tokenizer.ggml.fim_mid_token_id%22,4,126%5D&add=%5B%22tokenizer.ggml.fim_pre_token_id%22,4,124%5D&add=%5B%22tokenizer.ggml.fim_suf_token_id%22,4,125%5D'
    MODEL_DIR="${CACHE_DIR}/custom"
    MODEL_PATH="${MODEL_DIR}/Seed-Coder-8B-Base.gguf"
    if [ ! -f "$MODEL_PATH" ]; then
        mkdir -p "$MODEL_DIR"
        curl -fSL -C - -o "$MODEL_PATH" "$MODEL_URL" || exit 1
    fi
    _serve "$1" -a ByteDance-Seed/Seed-Coder-8B-Base \
        -m "$MODEL_PATH" \
        --spm-infill
elif [ "$2" = "deepseek" ]; then
    _serve "$1" -a deepseek-ai/DeepSeek-Coder-V2-Lite-Base \
        -hf legraphista/DeepSeek-Coder-V2-Lite-Base-IMat-GGUF:IQ4_NL
elif [ "$2" = "qwen" ]; then
    if [ "$1" = "low" ]; then
        _serve "$1" -a Qwen/Qwen2.5-Coder-7B \
            -hf mradermacher/Qwen2.5-Coder-7B-i1-GGUF:Q4_K_M
    elif [ "$1" = "medium" ]; then
        _serve "$1" -a cerebras/Qwen3-Coder-REAP-25B-A3B \
            -hf mradermacher/Qwen3-Coder-REAP-25B-A3B-i1-GGUF:Q4_K_M \
            -hfd unsloth/Qwen2.5-Coder-0.5B-Instruct-GGUF:Q8_0 \
            --draft 5
    elif [ "$1" = "high" ]; then
        _serve "$1" -a Qwen/Qwen3-Coder-30B-A3B-Instruct \
            -hf unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q8_K_XL \
            -hfd unsloth/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q8_0 \
            --draft 7
    fi
elif [ "$2" = "glm" ]; then
    # TODO: Remove unnecessary chat_template_kwargs && test with --jinja
    if [ "$1" = "low" ]; then
        _serve "$1" -a cerebras/GLM-4.7-Flash-REAP-23B-A3B \
            -hf unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF:IQ4_NL \
            --chat-template-kwargs '{"enable_thinking": false, "thinking": {"type": "disabled"}}'
    elif [ "$1" = "medium" ]; then
        _serve "$1" -a cerebras/GLM-4.7-Flash-REAP-23B-A3B \
            -hf unsloth/GLM-4.7-Flash-REAP-23B-A3B-GGUF:IQ4_NL \
            --chat-template-kwargs '{"enable_thinking": false, "thinking": {"type": "disabled"}}' \
            -hfd unsloth/Qwen2.5-Coder-0.5B-Instruct-GGUF:Q8_0 \
            --draft 5
    elif [ "$1" = "high" ]; then
        _serve "$1" -a zai-org/GLM-4.7-Flash \
            -hf unsloth/GLM-4.7-Flash-GGUF:Q8_K_XL \
            --chat-template-kwargs '{"enable_thinking": false, "thinking": {"type": "disabled"}}' \
            -hfd unsloth/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q8_0 \
            --draft 7
    fi
elif [ -n "$1" ]; then
    _serve "$@"
else
    echo "$HELP_MSG"
fi
