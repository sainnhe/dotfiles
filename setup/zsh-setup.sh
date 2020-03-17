#!/bin/env bash

sudo pacman -S lua zsh exa
chsh -s /usr/bin/zsh
mkdir ~/.zinit
git clone --depth 1 https://github.com/zdharma/zinit.git ~/.zinit/bin

ln -s /home/sainnhe/repo/dotfiles/.zshrc ~/.zshrc
ln -s /home/sainnhe/repo/dotfiles/.zsh-snippets ~/.zsh-snippets
cp /home/sainnhe/repo/dotfiles/.zsh-theme ~/
