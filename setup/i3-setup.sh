#!/bin/env bash

pikaur -S i3-gaps xorg-xrdb polybar lxappearance-gtk3 feh perl-anyevent-i3 compton-tryone-git redshiftgui-bin nm-connection-editor blueman gbacklight rofi

mkdir -p ~/.config
ln -s /home/sainnhe/repo/dotfiles/.config/i3 ~/.config/i3
