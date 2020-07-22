#!/bin/env sh

if [ "$1" = "general" ]; then
    pikaur -S \
        fzf \
        terminal-markdown-viewer \
        python2-pygments \
        nodejs-commitizen \
        nodejs-cz-conventional-changelog \
        pastebinit \
        tcping \
        hyperfine \
        fd \
        ytop \
        htop \
        ripgrep \
        ripgrep-all \
        bingrep-rs \
        xclip
    pikaur -S \
        npm \
        yarn \
        go \
        typescript \
        dotnet \
        lua
    sudo pacman -S nnn ranger atool elinks ffmpegthumbnailer highlight odt2txt perl-image-exiftool
elif [ "$1" = "physical" ]; then
    sudo pacman -S zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
    pikaur -S qv2ray-dev-git qv2ray-plugin-command-dev-git qv2ray-plugin-ssr-dev-git qv2ray-plugin-trojan-dev-git
    pikaur -S fontweak persepolis code typora iw bleachbit
    pikaur -S fcitx fcitx-configtool fcitx-libpinyin fcitx-cloudpinyin fcitx-table-extra fcitx-table-other kcm-fcitx fcitx-skins fcitx-skin-material
    pikaur -S wps-office-cn ttf-wps-fonts wps-office-mime-cn wps-office-mui-zh-cn wps-office-fonts
    sudo pacman -S wine xsettingsd deepin.com.qq.office lib32-freetype2-infinality-ultimate
    echo "TIM"
    echo ""
    echo "https://github.com/countstarlight/deepin-wine-tim-arch/issues/1"
    echo 'snippet-add tim         "xsettingsd &"'
# elif [ "$1" = "wsl" ]; then
fi
