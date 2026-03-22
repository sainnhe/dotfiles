#!/bin/bash

# 遇到错误立即退出
set -e

echo "🚀 开始清理旧的编译缓存和依赖..."
make distclean || true

echo "⚙️ 开始拉取依赖并编译 Neovim..."
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME/.local" -j$(nproc)

echo "📦 编译完成，开始安装到 ~/.local ..."
make install

echo "✅ Neovim 已成功安装！"
echo "👉 可执行文件: $HOME/.local/bin/nvim"
