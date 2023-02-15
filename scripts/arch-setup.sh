#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
NC='\033[0m'

DOTFILES_DIR=$(git rev-parse --show-toplevel)

# Util Func{{{
setup_symlink() {
    if [[ "$1" == *"/"* ]]; then
        DIR=$(echo "$1" | grep -o ".*\/")
        mkdir -p "$HOME/$DIR"
    fi
    ln -sf "$DOTFILES_DIR/$1" "$HOME/$1"
}

setup_copy() {
    if [[ "$1" == *"/"* ]]; then
        DIR=$(echo "$1" | grep -o ".*\/")
        mkdir -p "$HOME/$DIR"
    fi
    cp -rf "$DOTFILES_DIR/$1" "$HOME/$1"
}
#}}}
setup_dotfiles() { #{{{
    setup_copy .gitconfig
    setup_copy .gitignore_global
    setup_symlink .bashrc
    setup_symlink .w3m/config
    setup_symlink .weechat/weechat.conf
    setup_copy .aria2
    setup_copy .config/autostart
    setup_symlink .config/pip
    setup_copy .config/xsettingsd
    setup_copy .config/autostart-scripts
    setup_symlink .config/fontconfig/fonts.conf
    setup_symlink .config/helix/config.toml
    setup_copy .config/pikaur.conf
    setup_copy .config/fcitx5
    setup_symlink package.json
    setup_symlink .npmrc
    setup_copy .yarnrc
    setup_symlink .cargo/config.toml
    setup_copy .config/zathura/zathurarc
    setup_symlink .config/zathura/themes
    setup_copy .config/libinput-gestures.conf
    setup_symlink .config/QtProject/qtcreator/themes
    setup_symlink .config/QtProject/qtcreator/styles
    printf "${BBLUE}>> Setup root directory manually.${NC}\n"
} #}}}
setup_arch_repos() { #{{{
    sudo cp ~/repo/dotfiles/.root/etc/pacman.conf /etc/pacman.conf
    sudo pacman-key --init

    # personal repository
    curl -L https://repo.sainnhe.dev/sainnhe.gpg \
        | sudo pacman-key --add -
    sudo pacman-key --finger 16F249ED243F596E
    sudo pacman-key --lsign-key 16F249ED243F596E

    # linux surface
    wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \
        | sudo pacman-key --add -
    sudo pacman-key --finger 56C464BAAC421453
    sudo pacman-key --lsign-key 56C464BAAC421453

    # required packages
    sudo pacman -Sy
    sudo pacman -S archlinuxcn-keyring
} #}}}
setup_repos() { #{{{
    mkdir -p ~/.ssh
    cp ~/repo/dotfiles/.ssh/config ~/.ssh/
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -C "i@sainnhe.dev"
    ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -C "i@sainnhe.dev"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_ecdsa
    mkdir ~/repo
    cd ~/repo
    git clone https://github.com/sainnhe/dotfiles.git
    git clone https://git.sainnhe.dev/sainnhe/notes.git
    cd ../
    git clone https://aur.archlinux.org/pikaur.git
    cd ~/repo/pikaur
    makepkg -si
    sudo pacman -S python-pysocks asp
    printf "${BYELLOW}>> cat ~/.ssh/id_rsa.pub${NC}"
    cat ~/.ssh/id_rsa.pub
} #}}}
setup_network() { #{{{
    sudo pacman -S proxychains
    sudo systemctl enable --now NetworkManager
    sudo cp ~/repo/dotfiles/.root/etc/proxychains.conf /etc/proxychains.conf
    sudo systemctl enable --now iptables
    sudo systemctl enable --now firewalld
} #}}}
setup_sddm() { #{{{
    sudo pacman -S sddm
    pikaur -S sddm-config-editor-git sddm-sugar-candy-git
    sudo cp ~/repo/dotfiles/.root/etc/sddm.conf /etc/sddm.conf
    sudo cp ~/repo/dotfiles/.root/usr/share/sddm/themes/sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
} #}}}
setup_surface() { #{{{
    mkdir -p ~/playground
    cd ~/playground || exit
    # DKMS modules
    sudo pacman -S dkms acpi acpi_call-dkms
    # Install the kernel and firmwares
    pikaur -S \
        linux-surface-headers \
        linux-surface \
        linux-firmware-marvell \
        surface-ipts-firmware \
        aic94xx-firmware \
        wd719x-firmware \
        upd72020x-fw \
        libwacom-surface \
        surface-control \
        surface-dtx-daemon \
        power-profiles-daemon \
        libcamera \
        libcamera-tools \
        gst-plugin-libcamera
    # Post-Installation
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    sudo systemctl enable --now surface-dtx-daemon.service
    sudo systemctl enable --now iptsd.service
    sudo pacman -Rs linux linux-headers
    sudo sync
    echo "To configure kexec: sudo kexec -l /boot/vmlinuz-linux-surface --initrd=/boot/initramfs-linux-surface.img --reuse-cmdline"
} #}}}
setup_nvidia() { #{{{
    printf "${BYELLOW}>> Edit PKGBUILD for optimus-manager-qt${NC} [Enter to continue] "
    read -r
    pikaur -S \
        nvidia-dkms \
        nvidia-settings \
        nvidia-utils \
        opencl-nvidia \
        lib32-nvidia-utils \
        lib32-opencl-nvidia \
        virtualgl \
        lib32-virtualgl \
        libva-vdpau-driver-vp9-git \
        libvdpau \
        vdpauinfo \
        bbswitch-dkms \
        xorg-xrandr \
        optimus-manager-qt
    sudo sync
    # surface setup
    sudo mkdir -p /etc/modprobe.d
    sudo cp ~/repo/dotfiles/.root/etc/modprobe.d/surface.conf /etc/modprobe.d/
    sudo cp ~/repo/dotfiles/.root/etc/modprobe.d/nvidia.conf /etc/modprobe.d/
    sudo mkdir -p /etc/modules-load.d
    sudo cp ~/repo/dotfiles/.root/etc/modules-load.d/nvidia.conf /etc/modules-load.d/
    # X11 setup
    sudo mkdir -p /etc/X11/xorg.conf.d
    sudo cp ~/repo/dotfiles/.root/etc/X11/xorg.conf.d/20-intel.conf /etc/X11/xorg.conf.d/
    sudo cp ~/repo/dotfiles/.root/etc/X11/xorg.conf.d/20-nvidia.conf /etc/X11/xorg.conf.d/
    
    printf "\n\n${BBLUE}>> In ${BGREEN}/etc/X11/xorg.conf.d/20-nvidia.conf${NC}\n"
    printf "${BBLUE}>> Get PCI address: ${BGREEN}https://wiki.archlinux.org/index.php/NVIDIA_Optimus_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)${NC}\n"
    printf "${BBLUE}>> Adjust ${BGREEN}/usr/share/sddm/scripts/Xsetup${NC}\n"
} #}}}
setup_zsh() { #{{{
    sudo pacman -S lua zsh
    chsh -s /usr/bin/zsh
    ln -s /home/sainnhe/repo/dotfiles/.zshrc ~/.zshrc
    cp /home/sainnhe/repo/dotfiles/.zsh-theme/edge-dark.zsh ~/.zsh-theme
    printf "${BBLUE}>> Execute ${BYELLOW}'zsh'${BBLUE} to install zsh plugins${NC}\n"
} #}}}
setup_tmux() { #{{{
    sudo pacman -S xsel tmux python-requests fzf
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp /home/sainnhe/repo/dotfiles/.tmux.conf ~/.tmux.conf
    ln -s /home/sainnhe/repo/dotfiles/.tmux/tmuxline ~/.tmux/tmuxline
    printf "${BBLUE}>> Press ${BYELLOW}'prefix+I'${BBLUE} to install plugins.${NC}\n"
    echo "'prefix I' to install plugins"
} #}}}
setup_vim() { #{{{
    pikaur -S neovim-meta
    mkdir -p ~/.config
    mkdir -p ~/.local/share/nvim
    ln -sf /home/sainnhe/repo/dotfiles/.config/nvim ~/.vim
    ln -sf /home/sainnhe/repo/dotfiles/.config/nvim ~/.config/nvim
} #}}}
setup_rust() { #{{{
    sudo pacman -S rustup
    proxychains -q rustup install nightly
    rustup default nightly
    proxychains -q rustup component add \
        rust-analyzer-preview \
        rust-docs
    xdg-mime default firefox-developer-edition.desktop text/html
} #}}}
setup_pnpm() { #{{{
    cd ~
    pnpm install
} #}}}
setup_weechat() { #{{{
    proxychains -q curl -L --create-dirs -o ~/.weechat/python/autoload/autojoin.py http://www.weechat.org/files/scripts/autojoin.py
} #}}}
setup_plasma() { #{{{
    pikaur -S kde-meta
    sudo gpasswd -a "$USER" input
    libinput-gestures-setup autostart
    ln -sf /home/sainnhe/repo/dotfiles/.config/kwinrulesrc ~/.config/kwinrulesrc
    printf "${BBLUE}>> Edit /etc/default/grub to apply grub theme.${NC}\n"
    printf "${BBLUE}>> Set GRUB_DISABLE_OS_PROBER=false to enable detecting other OS-es.${NC}\n"
    printf "${BBLUE}>> Set GRUB_DEFAULT=x to change the boot order, where x is the index of boot item, begin by 0.${NC}\n"
    printf "${BBLUE}>> Execute 'grub-mkconfig -o /boot/grub/grub.cfg' to update grub.${NC}\n"
    printf "${BBLUE}>> Execute 'systemctl enable --now sddm' to enable and start plasma session.${NC}\n"
    printf "${BBLUE}>> Edit DefaultTimeoutStopSec in /etc/systemd/user.conf${NC}\n"
} #}}}
setup_fonts() { #{{{
    pikaur -S fonts-meta
} #}}}
setup_apps() { #{{{
    pikaur -S apps-common-meta apps-extra-meta pacman-hooks-meta grub-meta
} #}}}

if [ "$1" = 'dotfiles' ]; then
    setup_dotfiles
elif [ "$1" = 'arch_repos' ]; then
    setup_arch_repos
elif [ "$1" = 'repos' ]; then
    setup_repos
elif [ "$1" = 'network' ]; then
    setup_network
elif [ "$1" = 'sddm' ]; then
    setup_sddm
elif [ "$1" = 'surface' ]; then
    setup_surface
elif [ "$1" = 'nvidia' ]; then
    setup_nvidia
elif [ "$1" = 'zsh' ]; then
    setup_zsh
elif [ "$1" = 'tmux' ]; then
    setup_tmux
elif [ "$1" = 'vim' ]; then
    setup_vim
elif [ "$1" = 'rust' ]; then
    setup_rust
elif [ "$1" = 'pnpm' ]; then
    setup_pnpm
elif [ "$1" = 'weechat' ]; then
    setup_weechat
elif [ "$1" = 'plasma' ]; then
    setup_plasma
elif [ "$1" = 'fonts' ]; then
    setup_fonts
elif [ "$1" = 'apps' ]; then
    setup_apps
fi
# vim: set fdm=marker fmr={{{,}}}:
