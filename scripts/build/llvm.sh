#!/usr/bin/env bash

# 开启严格模式，遇到错误立即停止
set -euo pipefail

mkdir -p build
cd build

echo "==> 开始配置 LLVM 构建 (使用 Unix Makefiles)..."

cmake \
    -G "Unix Makefiles" \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$HOME/.local/llvm" \
    -DLLVM_TARGETS_TO_BUILD="Native" \
    -DLLVM_USE_LINKER="lld" \
    -DCMAKE_C_COMPILER_LAUNCHER="ccache" \
    -DCMAKE_CXX_COMPILER_LAUNCHER="ccache" \
    ../llvm

echo "==> 开始编译..."
# 使用 $(nproc) 自动获取 CPU 核心数进行并行编译
make -j $(nproc)

echo "==> 开始安装..."
make install

echo "==> LLVM 构建并安装完成！"
