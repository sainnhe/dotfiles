#!/bin/env bash

DOTFILES_DIR="/home/sainnhe/repo/dotfiles"

# Util Func{{{
setup_symlink() {
    if [[ "$1" == *"/"* ]]; then
        DIR=$(echo "$1" | grep -o ".*\/")
        mkdir -p "$HOME/$DIR"
    fi
    ln -s "$DOTFILES_DIR/$1" "$HOME/$1"
}

setup_copy() {
    if [[ "$1" == *"/"* ]]; then
        DIR=$(echo "$1" | grep -o ".*\/")
        mkdir -p "$HOME/$DIR"
    fi
    cp -r "$DOTFILES_DIR/$1" "$HOME/$1"
}
#}}}

setup_symlink ../.Xresources
setup_copy ../.redshiftgrc
setup_symlink ../.haxornewsconfig
setup_symlink ../.gitsomeconfig
setup_copy ../.gitconfig
setup_copy ../.ctags
setup_symlink ../.conkyrc
setup_symlink ../.bashrc
setup_symlink ../.w3m
setup_symlink ../.local/share/applications
setup_copy ../.aria2
setup_symlink ../.config/alacritty/alacritty.yml
setup_copy ../.config/autostart
setup_symlink ../.config/browsh/config.toml
setup_symlink ../.config/fontconfig/fonts.conf
setup_symlink ../.config/polybar
setup_symlink ../.config/rofi
setup_symlink ../.config/rtv
setup_symlink ../.config/compton.conf
setup_copy ../.config/pikaur.conf

echo "setup root directory manually"
