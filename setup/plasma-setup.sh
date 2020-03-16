#!/usr/bin/env bash

sudo pacman -S plasma
sudo pacman -S kde-applications
sudo pacman -S kvantum-qt5
sudo pacman -S plasma5-applets-active-window-control
pikaur -S capitaine-cursors numix-cursor-theme
mkdir -p ~/repo
cd ~/repo || exit
git clone --depth 1 https://github.com/vinceliuice/McMojave-circle.git
git clone --depth 1 https://github.com/vinceliuice/McMojave-kde.git
