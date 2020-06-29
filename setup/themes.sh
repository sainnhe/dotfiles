#!/usr/bin/env bash

# Icon/Cursor
pikaur -S capitaine-cursors numix-cursor-theme
pikaur -S papirus-icon-theme numix-circle-icon-theme-git

# GTK
pikaur -S arc-gtk-theme gtk-theme-arc-gruvbox-git snow-theme-git nordic-theme-git mojave-gtk-theme-git qogir-gtk-theme-git x-arc-plus x-arc-white x-arc-darker x-arc-shadow

# KDE
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
sudo pacman -S materia-kde kvantum-theme-materia
echo "https://github.com/EliverLara/Sweet/tree/nova/kde"
echo "https://www.pling.com/p/1305251/"
