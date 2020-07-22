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

setup_symlink .Xresources
setup_copy .redshiftgrc
setup_symlink .haxornewsconfig
setup_symlink .gitsomeconfig
setup_copy .gitconfig
setup_copy .ctags
setup_symlink .conkyrc
setup_symlink .bashrc
setup_symlink .w3m/config
setup_symlink .weechat/weechat.conf
setup_copy .aria2
setup_copy .config/alacritty/alacritty.yml
setup_copy ../.config/i3/config
setup_symlink ../.config/i3/scripts
setup_copy .config/autostart
setup_symlink .config/browsh/config.toml
setup_symlink .config/fontconfig/fonts.conf
setup_copy .config/polybar
setup_copy .config/rofi/config.rasi
setup_symlink .config/rofi/themes
setup_symlink .config/rtv
setup_symlink .config/picom.conf
setup_copy .config/pikaur.conf
setup_symlink .config/fcitx/conf
setup_symlink .config/fcitx/config
setup_symlink .config/fcitx/profile
setup_symlink package.json
setup_copy .config/zathura/zathurarc
setup_symlink .config/zathura/themes
setup_copy .config/libinput-gestures.conf
cp -r $DOTFILES_DIR/.local/share/applications/* ~/.local/share/applications/

echo "setup root directory manually"
