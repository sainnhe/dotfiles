#!/usr/bin/env bash

pikaur -S --asdeps \
        check-broken-packages-pacman-hook-git \
        pacdiff-pacman-hook-git \
        systemd-boot-pacman-hook \
        systemd-cleanup-pacman-hook \
        sync-pacman-hook-git
