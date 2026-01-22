#!/usr/bin/env bash

if [ "$(uname)" = "Darwin" ]; then
    CACHE_DIR="$HOME/Library/Caches/llama.cpp"
else
    CACHE_DIR="$HOME/.cache/llama.cpp"
fi

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
        echo "Usage: _serve {low|medium|high} [additional llama-server args]"
        echo "Example: _serve medium -m ./models/qwen2.5-coder-32b-q4_k_m.gguf"
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
    _serve "$1" --spm-infill \
        -m "$CACHE_DIR/custom/mradermacher_Seed-Coder-8B-Base-GGUF_Seed-Coder-8B-Base.Q4_K_M.edited.gguf"
elif [ "$2" = "deepseek" ]; then
    _serve "$1" -hf QuantFactory/DeepSeek-Coder-V2-Lite-Base-GGUF:Q4_K_S
elif [ "$2" = "qwen-7b" ]; then
    _serve "$1" -hf QuantFactory/Qwen2.5-Coder-7B-GGUF:Q4_K_M
elif [ "$2" = "qwen-14b" ]; then
    _serve "$1" -hf QuantFactory/Qwen2.5-Coder-14B-GGUF:Q4_K_M
elif [ "$2" = "qwen-30b" ]; then
    _serve "$1" -hf unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q8_0 \
        -hfd unsloth/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q8_0 \
        --draft 7
elif [ "$2" = "glm-4.7-flash" ]; then
    _serve "$1" -hf unsloth/GLM-4.7-Flash-GGUF:Q8_0 \
        --chat-template-kwargs '{"enable_thinking": false}' \
        -hfd unsloth/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q8_0 \
        --draft 7
elif [ "$2" = "iquest-coder" ]; then
    _serve "$1" -hf mradermacher/IQuest-Coder-V1-40B-Base-GGUF:Q6_K \
        -hfd unsloth/Qwen2.5-Coder-1.5B-Instruct-GGUF:Q8_0 \
        --draft 7
elif [ -n "$1" ]; then
    _serve "$@"
else
    echo "Usage: $0 {low|medium|high} {seed|deepseek|qwen-7b|qwen-14b|qwen-30b|glm-4.7-flash|iquest-coder|args...}"
fi
