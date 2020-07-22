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
    sudo pacman -S zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
    pikaur -S qv2ray-dev-git qv2ray-plugin-command-dev-git qv2ray-plugin-ssr-dev-git qv2ray-plugin-trojan-dev-git
elif [ "$1" = "physical" ]; then
    pikaur -S fontweak persepolis code typora iw
    pikaur -S fcitx fcitx-configtool fcitx-libpinyin fcitx-cloudpinyin fcitx-table-extra fcitx-table-other kcm-fcitx fcitx-skins fcitx-skin-material
    # sudo pacman -S wps-office-cn
    # pikaur -S ttf-wps-fonts wps-office-mime-cn wps-office-mui-zh-cn
    # sudo pacman -S wine
    # sudo pacman -S xsettingsd deepin.com.qq.office
    # echo "TIM"
    # echo ""
    # echo "https://github.com/countstarlight/deepin-wine-tim-arch/issues/1"
    # echo 'snippet-add tim         "xsettingsd &"'
# elif [ "$1" = "wsl" ]; then
fi
