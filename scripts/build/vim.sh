#!/usr/bin/env bash

set -euo pipefail

echo "🚀 开始清理旧的编译缓存..."
make distclean || true

echo "⚙️ 开始配置 Vim 编译选项..."
./configure \
    --prefix="$HOME/.local" \
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp=dynamic \
    --with-python3-command=python3 \
    --enable-terminal \
    --disable-gui \
    --enable-fail-if-missing

echo "🔨 配置完成，开始调用多核编译..."
make -j"$(nproc)"

echo "📦 编译完成，开始安装到 ~/.local ..."
make install

echo "✅ Vim 已成功安装！"
echo "👉 可执行文件: $HOME/.local/bin/vim"
