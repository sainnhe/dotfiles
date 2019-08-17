#!/bin/env sh

defaultTrue() {
    read -r judgement
    if [ "$judgement"x != "n"x ]; then
        judgement="y"
    fi
}
defaultFalse() {
    read -r judgement
    if [ "$judgement"x != "y"x ]; then
        judgement="n"
    fi
}

if [ "$1" = "usb" ]; then
    # Preparation{{{
    # update system time
    timedatectl set-ntp true
    #}}}
    # Partition{{{
    fdisk -l
    echo ""
    echo "Recommendation: "
    echo "create GPT partition table if it's a new disk"
    echo "+512M efi /boot"
    echo "+4G swap /swap"
    echo "+30G xfs /home"
    echo "+30G ext4 /"
    echo ""
    echo "Tips in fdisk:"
    echo "m    help"
    echo "g    create GPT partition table"
    echo "p    print current partition info"
    echo "n    new partition"
    echo "d    delete partition"
    echo "t    change type"
    echo "l    list available types"
    echo "w    write"
    echo "q    quit"
    echo -n "Execute 'fdisk /dev/sdx' to start the partition operation. (enter to continue) "
    read -r wait
    bash
    #}}}
    # Filesystems{{{
    echo "mkswap /dev/sdxY"
    echo "swapon /dev/sdxY"
    echo "mkfs.ext4 /dev/sdxY"
    echo "mkfs.xfs /dev/sdxY"
    echo "mkfs.fat -F32 /dev/sdxY"
    echo -n "'fdisk -l' to get more info. (enter to continue)"
    read -r wait
    bash
    #}}}
    # Mount{{{
    echo -n "mount like this: 'mount /dev/sdxY /mnt'. (enter to continue)"
    read -r wait
    bash
    #}}}
    # Mirror{{{
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    echo "[1] 163; [2] aliyun; [3] tuna"
    echo -n "> "
    read -r mirror
    if [ "$mirror" = "1" ]; then
        echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    elif [ "$mirror" = "2" ]; then
        echo 'Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    elif [ "$mirror" = "3" ]; then
        echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    else
        echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    fi
    #}}}
    pacman -Syy
    pacstrap /mnt base base-devel
    echo -n "genfstab? [Y/n] "
    defaultTrue
    if [ "$judgement" = "y"]; then
        genfstab -L /mnt >> /mnt/etc/fstab
        less /mnt/etc/fstab
    fi
    echo "execute 'arch-chroot /mnt'"
elif [ "$1" = "chroot" ]; then
    passwd
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    hwclock --systohc
    rm /etc/pacman.d/mirrorlist
    echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = https://archive.archlinux.org/repos/2019/03/15/$repo/os/$arch' /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = https://archive.archlinux.org/repos/last/$repo/os/$arch' /etc/pacman.d/mirrorlist
    pacman -Syyuu
    pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager intel-ucode v2ray sudo mesa xf86-video-intel xorg git
    vim /etc/locale.gen
    locale-gen
    echo -n "add this to the first line: 'LANG=en_US.UTF-8' (enter to continue) "
    vim /etc/locale.conf
    echo -n "set hostname (enter to continue) "
    vim /etc/hostname
    rm /etc/hosts
    echo '127.0.0.1	localhost' > /etc/hosts
    sed -ri -e '$a ::1		localhost' /etc/hosts
    sed -ri -e '$a 127.0.1.1	myhostname.localdomain	myhostname' /etc/hosts
    vim /etc/hosts
    pacman -S os-prober grub efibootmgr
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=archlinux
    grub-mkconfig -o /boot/grub/grub.cfg
    sed -ri -e 's/use_lvmetad = 1/use_lvmetad = 0/' /etc/lvm/lvm.conf
    useradd -m -G wheel sainnhe
    passwd sainnhe
    visudo
    echo ""
    echo "finish"
elif [ "$1" = "user" ]; then
    # Basic{{{
    mkdir ~/repo
    git clone https://github.com/sainnhe/dotfiles.git ~/repo/
    git clone https://github.com/sainnhe/scripts.git ~/repo/
    git clone https://aur.archlinux.org/pikaur.git ~/repo/
    cd ~/repo/pikaur
    sudo makepkg -si
    #}}}
    # Network{{{
    sudo systemctl disable netctl
    sudo systemctl enable NetworkManager
    sudo cp ~/repo/scripts/func/v2ray/v2ray-tcp.json /etc/v2ray/config.json
    sudo systemctl enable v2ray
    sudo systemctl start v2ray
    sudo pacman -S proxychains
    sudo cp ~/repo/dotfiles/.root/etc/proxychains.conf /etc/proxychains.conf
    #}}}
    # LightDM{{{
    sudo pacman -S lightdm
    sudo pacman -S lightdm-webkit2-greeter
    pikaur -S lightdm-webkit2-theme-material2
    sudo systemctl enable lightdm
    sudo cp ~/repo/dotfiles/.root/etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf
    sudo cp ~/repo/dotfiles/.root/etc/lightdm/lightdm-webkit2-greeter.conf etc/lightdm/lightdm-webkit2-greeter.conf
    #}}}
    # Surface Linux{{{
    git config --global http.proxy socks5://127.0.0.1:1080
    git clone https://github.com/dmhacker/arch-linux-surface.git ~/repo/
    sudo pacman -S wget unzip
    cd ~/repo
    proxychains -q wget https://github.com/jakeday/linux-surface/archive/master.zip
    unzip linux-surface-master.zip
    sudo mkdir arch-linux-surface/.cache_setup
    sudo mv linux-surface-master arch-linux-surface/.cache_setup/linux-surface
    cd arch-linux-surface
    sudo bash setup.sh
    proxychains -q wget https://github.com/dmhacker/arch-linux-surface/releases/download/5.1.15-1/linux-surface-5.1.15-1-x86_64.pkg.tar.xz
    proxychains -q wget https://github.com/dmhacker/arch-linux-surface/releases/download/5.1.15-1/linux-surface-docs-5.1.15-1-x86_64.pkg.tar.xz
    proxychains -q wget https://github.com/dmhacker/arch-linux-surface/releases/download/5.1.15-1/linux-surface-headers-5.1.15-1-x86_64.pkg.tar.xz
    sudo pacman -U linux-surface-5.1.15-1-x86_64.pkg.tar.xz
    sudo pacman -U linux-surface-docs-5.1.15-1-x86_64.pkg.tar.xz linux-surface-headers-5.1.15-1-x86_64.pkg.tar.xz
    pikaur -S update-grub
    sudo update-grub
    #}}}
    sudo pacman -S gvim firefox-developer-edition telegram-desktop w3m aria2
    echo "setup i3, zsh, tmux, vim manually"
fi
