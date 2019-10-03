#!/bin/env bash

sudo pacman -S xsel tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.tmux
ln -s /home/sainnhe/repo/dotfiles/.tmux.conf ~/.tmux.conf
ln -s /home/sainnhe/repo/dotfiles/.tmux/tmuxline ~/.tmux/tmuxline

echo "'prefix I' to install plugins"
