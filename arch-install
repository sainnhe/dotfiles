#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
NC='\033[0m'

setup_live() { #{{{
    printf "${BBLUE}>> Make sure you have connected to the internet.${NC} [Enter to continue] "
    read -r
    timedatectl set-local-rtc 1
    # Partition{{{
    printf "${BYELLOW}>> fdisk -l${NC}\n"
    echo ""
    fdisk -l
    echo ""
    printf "${BBLUE}>> Recommendations for partition:${GREEN}\n"
    echo ""
    echo "create GPT partition table if it's a new disk"
    echo "+512M efi /boot"
    echo "+4G swap /swap"
    echo "+30G xfs /home"
    echo "+30G xfs /"
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
    echo ""
    printf "${BBLUE}>> Execute ${BYELLOW}'fdisk /dev/sdx'${BBLUE} to start the partition operation.${NC} [Enter to continue] "
    read -r
    printf "${BYELLOW}>> sh${NC}\n"
    sh
    #}}}
    # Filesystems{{{
    printf "${BBLUE}>> Recommendations for filesystems:${GREEN}\n"
    echo ""
    echo "mkswap /dev/sdxY"
    echo "swapon /dev/sdxY"
    echo "mkfs.ext4 /dev/sdxY"
    echo "mkfs.xfs /dev/sdxY"
    echo "mkfs.fat -F32 /dev/sdxY"
    echo ""
    printf "${BBLUE}>> Execute ${BYELLOW}'fdisk -l'${BBLUE} to get more info.${NC} [Enter to continue] "
    read -r
    printf "${BYELLOW}>> sh${NC}\n"
    sh
    #}}}
    # Mount{{{
    printf "${BBLUE}>> Mount like this: ${BYELLOW}'mount /dev/sdxY /mnt'${NC} [Enter to continue] "
    read -r
    printf "${BYELLOW}>> sh${NC}\n"
    sh
    #}}}
    # Mirror{{{
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    printf "${BBLUE}>> Select the mirror:${NC}\n"
    printf "${BGREEN}[1]${NC} tuna; ${BGREEN}[2]${NC} 163; ${BGREEN}[3]${NC} aliyun\n"
    printf "${BBLUE}>>${NC} "
    read -r mirror
    if [ "$mirror" = "1" ]; then
        echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
    elif [ "$mirror" = "2" ]; then
        echo 'Server = http://mirrors.163.com/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
    elif [ "$mirror" = "3" ]; then
        echo 'Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
    else
        echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
    fi
    (exit 1)
    while [ $? -ne 0 ]; do
        pacman -Syy
    done
    #}}}
    (exit 1)
    while [ $? -ne 0 ]; do
        pacstrap /mnt base base-devel linux linux-firmware linux-headers
    done
    genfstab -L /mnt >>/mnt/etc/fstab
    printf "${BBLUE}>> Execute ${BYELLOW}'arch-chroot /mnt'${NC}\n"
} #}}}
setup_chroot() { #{{{
    passwd
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    timedatectl set-local-rtc 1
    hwclock --systohc --localtime
    rm /etc/pacman.d/mirrorlist
    echo 'Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
    (exit 1)
    while [ $? -ne 0 ]; do
        pacman -Syyuu
    done
    #{{{Basic packages
    (exit 1)
    while [ $? -ne 0 ]; do
        pacman -S \
            iwd \
            dialog \
            ntfs-3g \
            networkmanager \
            intel-ucode \
            mesa \
            xorg \
            xorg-drivers \
            os-prober \
            grub \
            efibootmgr \
            vim \
            git \
            wget \
            openssh
    done
    sync
    #}}}
    printf "${BBLUE}>> Edit ${BGREEN}/etc/locale.gen${NC} [Enter to continue] "
    read -r
    vim /etc/locale.gen
    locale-gen
    echo 'LANG=en_US.UTF-8' >/etc/locale.conf
    printf "${BBLUE}>> Set hostname${NC} [Enter to continue] "
    read -r
    echo 'myhostname' >/etc/hostname
    vim /etc/hostname
    rm /etc/hosts
    cat >/etc/hosts <<EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname
EOF
    vim /etc/hosts
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ArchLinux
    grub-mkconfig -o /boot/grub/grub.cfg
    # sed -ri -e 's/use_lvmetad = 1/use_lvmetad = 0/' /etc/lvm/lvm.conf
    useradd -m -G wheel,audio,video,floppy,games -c "Sainnhe Park" sainnhe
    passwd sainnhe
    visudo
} #}}}

if [ "$1" = 'live' ]; then
    setup_live
elif [ "$1" = 'chroot' ]; then
    setup_chroot
fi
# vim: set fdm=marker fmr={{{,}}}:
