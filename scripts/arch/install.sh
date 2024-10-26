#!/usr/bin/env bash

echo "Be sure to boot from UEFI! If you are using rufus to create boot media, select GPT partition scheme for UEFI."

setup_live() { #{{{
    timedatectl set-local-rtc 1
    fdisk -l
    echo "Create a single btrfs. No need to create /boot, /boot/efi, /swap because we will setup dual boot."
    fdisk /dev/nvme0n1
    echo "Type 'n' to create a new partition, 't' to change type, 'w' to write changes."
    mkfs.btrfs --checksum xxhash -L ArchLinux -O block-group-tree /dev/nvme0n1pN # N is the number of the partition
    mount /dev/nvme0n1pN /mnt
    echo "Edit pacman.conf to change parallel downloads to 8, edit /etc/pacman.d/mirrorlist to select a mirror."
    pacstrap -K /mnt \
        base \
        base-devel \
        linux \
        linux-headers \
        linux-firmware \
        amd-ucode \
        btrfs-progs \
        networkmanager \
        iwd \
        vim \
        os-prober \
        efibootmgr \
        grub
    genfstab -L /mnt >>/mnt/etc/fstab
    echo "Copy pacman.conf and mirrorlist to chroot if you want."
    arch-chroot /mnt
} #}}}
setup_chroot() { #{{{
    # User
    passwd
    useradd -m -G wheel,audio,video,floppy,games -c "Sainnhe Park" sainnhe
    passwd sainnhe
    visudo
    # Time
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    timedatectl set-local-rtc 1
    hwclock --systohc --localtime
    # Locale
    vim /etc/locale.gen
    locale-gen
    echo 'LANG=en_US.UTF-8' >/etc/locale.conf
    # Host/Nework
    echo 'archlinux' >/etc/hostname
    cat >/etc/hosts <<EOF
127.0.0.1	localhost
::1		localhost
EOF
    systemctl enable NetworkManager
    # Grub
    # Mount windows efi partition to /boot/efi
    mkdir /boot/efi
    mount /dev/nvme0n1p1 /boot/efi
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux
    umount /boot/efi
    grub-mkconfig -o /boot/grub/grub.cfg
    sync
} #}}}
setup_reboot() { #{{{
    # Swap
    btrfs subvolume create /swap
    btrfs filesystem mkswapfile --size 4g --uuid clear /swap/swapfile
    swapon /swap/swapfile
    echo '/swap/swapfile none swap defaults 0 0' >> /etc/fstab
    # Arch Linux CN
    echo '[archlinuxcn]' >> /etc/pacman.conf
    echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf
    # Arch4edu
    echo '[arch4edu]' >> /etc/pacman.conf
    echo 'Server = https://repository.arch4edu.org/$arch' >> /etc/pacman.conf
    pacman-key --recv-keys 7931B6D628C8D3BA
    pacman-key --finger 7931B6D628C8D3BA
    pacman-key --lsign-key 7931B6D628C8D3BA
    # Install AUR Helper
    pacman -Sy
    pacman -S archlinuxcn-keyring
    pacman -S pikaur
} #}}}

if [ "$1" = 'live' ]; then
    setup_live
elif [ "$1" = 'chroot' ]; then
    setup_chroot
elif [ "$1" = 'reboot' ]; then
    setup_reboot
fi

# vim: set fdm=marker fmr={{{,}}}:
