#!/usr/bin/env bash

sudo pacman -S plasma
sudo pacman -S \
    akregator \
    ark \
    juk \
    kaddressbook \
    kalarm \
    kcron \
    dolphin \
    dolphin-plugins \
    kmail \
    dragon \
    elisa \
    ffmpegthumbs \
    gwenview \
    kate \
    kdeconnect \
    kdesdk-thumbnailers \
    kfind \
    kgpg \
    khelpcenter \
    kio \
    kio-extras \
    kio-gdrive \
    kipi-plugins \
    kleopatra \
    kmag \
    kmix \
    kmousetool \
    knotes \
    kdegraphics-mobipocket \
    kdegraphics-thumbnailers \
    kdenetwork-filesharing \
    kdepim-addons \
    kolourpaint \
    konsole \
    kontact \
    korganizer \
    krdc \
    krfb \
    kross-interpreters \
    ksystemlog \
    ktimer \
    kwalletmanager \
    mbox-importer \
    okular \
    pim-data-exporter \
    spectacle \
    svgpart \
    telepathy-kde-accounts-kcm \
    telepathy-kde-approver \
    telepathy-kde-auth-handler \
    telepathy-kde-call-ui \
    telepathy-kde-common-internals \
    telepathy-kde-contact-list \
    telepathy-kde-contact-runner \
    telepathy-kde-desktop-applets \
    telepathy-kde-filetransfer-handler \
    telepathy-kde-integration-module \
    telepathy-kde-send-file \
    telepathy-kde-text-ui \
    yakuake \
    zeroconf-ioslave \
    konversation \
    keditbookmarks \
    kget \
    ktorrent \
    kplotting \
    kdewebkit \
    geoip \
    kvantum-qt5 \
    qtcurve-kde \
    plasma5-applets-active-window-control
pikaur -S \
    latte-dock-git \
    plasma5-applets-virtual-desktop-bar-git \
    plasma5-applets-window-title \
    plasma5-applets-latte-separator \
    plasma5-applets-window-buttons \
    plasma5-applets-betterinlineclock-git \
    libinput-gestures \
    gestures \
    kwin-scripts-forceblur
sudo gpasswd -a "$USER" input
libinput-gestures-setup autostart
ln -s /home/sainnhe/repo/dotfiles/.config/kwinrulesrc ~/.config/kwinrulesrc
echo ""
echo "Blur:"
echo "System Settings -> Kwin Scripts -> Force Blur"
echo "Shortcuts:"
echo "/home/sainnhe/repo/scripts/func/plasma-blur.sh 'rofi -show drun' 'Rofi'"
