#!/bin/env sh

if [ "$1" = "init" ]; then
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Syyu base base-devel
    useradd -m -G wheel sainnhe
    passwd sainnhe
    echo "> ubuntu config --default-user username"
elif [ "$1" = "base" ]; then
    rm /etc/pacman.d/mirrorlist
    echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = http://mirrors.163.com/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = https://archive.archlinux.org/repos/2019/03/15/$repo/os/$arch' /etc/pacman.d/mirrorlist
    sed -ri -e '$a # Server = https://archive.archlinux.org/repos/last/$repo/os/$arch' /etc/pacman.d/mirrorlist
    pacman -Syyuu
    pacman -S sudo vi vim aria2 curl wget git dialog wpa_supplicant ntfs-3g v2ray w3m proxychains lsd svn fzf openssh
    visudo
    cd /tmp
    wget https://github.com/sainnhe/gruvbox-material/files/3513850/fakeroot-tcp-1.23-1-x86_64.pkg.tar.xz.zip
    mv fakeroot-tcp-1.23-1-x86_64.pkg.tar.xz.zip fakeroot-tcp-1.23-1-x86_64.pkg.tar.xz
    pacman -U fakeroot-tcp-1.23-1-x86_64.pkg.tar.xz
    timedatectl set-ntp true
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    hwclock --systohc
    timedatectl set-local-rtc 1 --adjust-system-clock
    vim /etc/locale.gen
    locale-gen
    echo -n "add this to the first line: 'LANG=en_US.UTF-8' (enter to continue) "
    read -r wait
    vim /etc/locale.conf
    vim /etc/proxychains.conf
elif [ "$1" = "user" ]; then
    ssh-keygen -t rsa -b 4096 -C "sainnhe@gmail.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    mkdir ~/repo
    cd ~/repo
    git config --global http.proxy socks5://127.0.0.1:1080
    git clone https://github.com/sainnhe/dotfiles.git
    git clone https://github.com/sainnhe/scripts.git
    git clone https://github.com/sainnhe/notes.git
    cd dotfiles
    git remote set-url origin git@github.com:sainnhe/dotfiles.git
    cd ../scripts
    git remote set-url origin git@github.com:sainnhe/scripts.git
    cd ../notes
    git remote set-url origin git@github.com:sainnhe/notes.git
    cd ../
    git clone https://aur.archlinux.org/pikaur-git.git
    cd ~/repo/pikaur-git
    makepkg -si
    sudo pacman -S python-pysocks
    echo "setup dotfiles, zsh, tmux, vim manually"
fi
