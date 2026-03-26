#!/usr/bin/env bash

# 开启严格模式，遇到错误立即退出
set -euo pipefail

# https://mirrors.tencent.com/gnu/ncurses
NCURSES_VER="6.6"
NCURSES_MAJOR="${NCURSES_VER%%.*}"
export LOCAL_INSTALL_DIR="$HOME/.local"

# 记录 tmux 源码目录路径
TMUX_SRC_DIR="$(pwd)"

# 前置防呆检查：确保在 tmux 源码目录下执行
if [ ! -f "autogen.sh" ] || [ ! -f "tmux.c" ]; then
    echo "❌ 错误：请在 tmux 的源代码根目录下运行此脚本！"
    exit 1
fi

echo "==> 🚀 开始在临时目录构建 ncurses ${NCURSES_VER} ..."

# 创建临时工作目录，防止污染 tmux 源码树
WORK_DIR=$(mktemp -d)
# 确保脚本无论是成功执行还是中途报错退出，都能清理临时目录
trap 'rm -rf "$WORK_DIR"' EXIT

cd "$WORK_DIR"
echo "    -> 正在下载 ncurses 源码..."
curl -fSL -o ncurses.tgz "https://mirrors.tencent.com/gnu/ncurses/ncurses-${NCURSES_VER}.tar.gz"
tar xzf ncurses.tgz
cd "ncurses-${NCURSES_VER}"

echo "    -> 正在配置并编译 ncurses..."
./configure --prefix="$LOCAL_INSTALL_DIR" \
            --enable-widec \
            --with-shared \
            --without-debug \
            --without-ada \
            --without-tests \
            --with-xterm-kbs=del \
            --with-termlib \
            --enable-pc-files \
            --with-pkg-config-libdir="$LOCAL_INSTALL_DIR/lib/pkgconfig"

make -j"$(nproc)"
make install

echo "    -> 创建 tinfo 软链接..."
cd "$LOCAL_INSTALL_DIR/lib"
ln -sf "libncursesw.so.${NCURSES_VER}" "libtinfo.so.${NCURSES_VER}"
ln -sf "libncursesw.so.${NCURSES_MAJOR}" "libtinfo.so.${NCURSES_MAJOR}"
ln -sf "libncursesw.so" "libtinfo.so"

cd "$LOCAL_INSTALL_DIR/lib/pkgconfig"
# 兼容处理：确保 tinfo.pc 存在
if [ -f "tinfow.pc" ]; then
    ln -sf tinfow.pc tinfo.pc
elif [ -f "ncursesw.pc" ]; then
    ln -sf ncursesw.pc tinfo.pc
fi

echo "==> ✅ ncurses 构建完成！"
echo "---------------------------------------------------"

echo "==> 🚀 开始构建 tmux ..."
cd "$TMUX_SRC_DIR"

# 生成 configure 脚本
./autogen.sh

# 将 ~/.local 注入到编译环境，增加 ncursesw 头文件路径防止找不到 <ncurses.h>
export PKG_CONFIG_PATH="$LOCAL_INSTALL_DIR/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
export CFLAGS="-I$LOCAL_INSTALL_DIR/include -I$LOCAL_INSTALL_DIR/include/ncursesw"
export CPPFLAGS="-I$LOCAL_INSTALL_DIR/include -I$LOCAL_INSTALL_DIR/include/ncursesw"
export LDFLAGS="-L$LOCAL_INSTALL_DIR/lib -Wl,-rpath,$LOCAL_INSTALL_DIR/lib"

./configure \
    --prefix="${LOCAL_INSTALL_DIR}" \
    --enable-utf8proc \
    --enable-sixel

echo "    -> 开始编译 tmux..."
make -j"$(nproc)"

echo "    -> 开始安装 tmux..."
make install

echo "==> 🎉 tmux 构建并安装完成！"
echo "👉 可执行文件位于: $LOCAL_INSTALL_DIR/bin/tmux"
