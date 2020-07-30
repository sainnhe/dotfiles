#!/bin/env bash

pikaur -S \
    nvidia-beta-dkms \
    nvidia-settings-beta \
    nvidia-utils-beta \
    opencl-nvidia-beta \
    lib32-nvidia-utils-beta \
    lib32-opencl-nvidia-beta \
    virtualgl \
    lib32-virtualgl \
    libva-vdpau-driver-vp9 \
    libvdpau \
    vdpauinfo \
    bbswitch-dkms \
    xorg-xrandr \
    optimus-manager-qt-kde
# surface setup
sudo mkdir -p /etc/modprobe.d
sudo cp ~/repo/dotfiles/.root/etc/modprobe.d/dgpu.conf /etc/modprobe.d/
sudo cp ~/repo/dotfiles/.root/etc/modprobe.d/blacklist-nouveau.conf /etc/modprobe.d/
# nvidia setup
sudo mkdir -p /etc/modules-load.d
sudo cp ~/repo/dotfiles/.root/etc/modules-load.d/nvidia.conf /etc/modules-load.d/
# X11 setup
sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp ~/repo/dotfiles/.root/etc/X11/xorg.conf.d/20-intel.conf /etc/X11/xorg.conf.d/
sudo cp ~/repo/dotfiles/.root/etc/X11/xorg.conf.d/20-nvidia.conf /etc/X11/xorg.conf.d/

echo ""
echo "In /etc/X11/xorg.conf.d/20-nvidia.conf"
echo "Get PCI address: https://wiki.archlinux.org/index.php/NVIDIA_Optimus_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)"
echo ""
echo "/usr/share/sddm/scripts/Xsetup"
