#!/usr/bin/env bash

# Icon/Cursor
pikaur -S \
    papirus-icon-theme \
    capitaine-cursors \
    numix-cursor-theme

# GTK
pikaur -S \
    arc-gtk-theme \
    x-arc-plus \
    x-arc-white \
    x-arc-darker \
    x-arc-shadow

# KDE
pikaur -S pikaur -S \
    sierrabreeze-kwin-decoration-git \
    sensual-kde-theme-git \
    sensual-kvantum-theme-git \
    sensual-breeze-icons-git \
    sensual-breeze-git

# Extras
mkdir -p ~/repo
cd ~/repo || exit
git clone --depth 1 https://github.com/vinceliuice/McMojave-circle.git
sh ~/repo/McMojave-circle/install.sh
git clone --depth 1 https://github.com/vinceliuice/McMojave-kde.git
sh ~/repo/McMojave-kde/install.sh
git clone --depth 1 https://github.com/vinceliuice/Qogir-kde.git
sh ~/repo/Qogir-kde/install.sh
git clone --depth 1 https://github.com/vinceliuice/Qogir-icon-theme.git
sh ~/repo/Qogir-icon-theme/install.sh
git clone --depth 1 https://github.com/vinceliuice/Canta-kde.git
sh ~/repo/Canta-kde/install.sh
git clone --depth 1 https://github.com/vinceliuice/Canta-theme.git
sh ~/repo/Canta-theme/install.sh -i
git clone --depth 1 https://github.com/yeyushengfan258/Tencent-icon-theme.git
sh ~/repo/Tencent-icon-theme/install.sh
echo "https://github.com/EliverLara/Sweet/tree/nova/kde"
echo "https://www.pling.com/p/1305251/"
