#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://127.0.0.1:8081/v1/chat/completions}"
REPEAT="${2:-30}" # 默认 1 倍短上下文；传 30 可构造约 15K+ 长上下文压测 Prefill 和峰值显存

PAYLOAD=$(python3 -c '
import json, sys

repeat = int(sys.argv[1])
code_block = """
struct ggml_tensor * ggml_mul_mat_q4_k(struct ggml_context * ctx, struct ggml_tensor * a, struct ggml_tensor * b) {
    GGML_ASSERT(ggml_can_mul_mat(a, b));
    struct ggml_tensor * result = ggml_new_tensor_4d(ctx, GGML_TYPE_F32, b->ne[1], a->ne[1], b->ne[2], b->ne[3]);
    result->op = GGML_OP_MUL_MAT;
    result->src[0] = a;
    result->src[1] = b;
    return result;
}
""" * repeat

prompt = code_block + "\n请将上述 ggml C++ 函数重构成支持 4D batch 广播的版本，补充关键断言注释，并编写对应的 C++ 单元测试。"

print(json.dumps({
    "model": "Qwen/Qwen3.8-27B",
    "messages": [{"role": "user", "content": prompt}],
    "max_tokens": 512,
    "temperature": 1.0,
    "stream": False
}))
' "$REPEAT")

START_NS=$(date +%s%N)

RESPONSE=$(curl -sS -X POST "$URL" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

END_NS=$(date +%s%N)

echo "$RESPONSE" | python3 -c '
import json, sys

elapsed_s = (int(sys.argv[1]) - int(sys.argv[2])) / 1e9
data = json.load(sys.stdin)

if "error" in data:
    print("请求失败:", data["error"])
    sys.exit(1)

t = data.get("timings", {})
pp_n = t.get("prompt_n", 0)
pp_tps = t.get("prompt_per_second", 0.0)
tg_n = t.get("predicted_n", 0)
tg_tps = t.get("predicted_per_second", 0.0)

print(f"Prompt 处理 : {pp_n} tokens | 速度: {pp_tps:.2f} t/s")
print(f"Token 生成  : {tg_n} tokens | 速度: {tg_tps:.2f} t/s")

if "draft_n" in t and t["draft_n"] > 0:
    draft_n = t["draft_n"]
    acc_n = t.get("draft_n_accepted", 0)
    print(f"投机采样    : 提议 {draft_n} | 接受 {acc_n} | 接受率: {acc_n / draft_n * 100:.1f}%")

print(f"端到端耗时  : {elapsed_s:.2f} s")
' "$END_NS" "$START_NS"
