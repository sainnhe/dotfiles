#!/bin/env bash

sudo pacman -S lua zsh
chsh -s /usr/bin/zsh
mkdir ~/.zplugin
git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin

ln -s /home/sainnhe/repo/dotfiles/.zshrc ~/.zshrc
ln -s /home/sainnhe/repo/dotfiles/.zsh-snippets ~/.zsh-snippets
cp /home/sainnhe/repo/dotfiles/.zsh-theme ~/
