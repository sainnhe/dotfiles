#!/usr/bin/env bash

sudo pacman -S plasma
sudo pacman -S kde-applications
sudo pacman -S kvantum-qt5
sudo pacman -S plasma5-applets-active-window-control
sudo pacman -S latte-dock
pikaur -S capitaine-cursors numix-cursor-theme
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
echo "https://store.kde.org/p/1364064/"
echo "https://github.com/EliverLara/Sweet/tree/nova/kde"
echo "https://www.pling.com/p/1305251/"
