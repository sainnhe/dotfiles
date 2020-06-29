#!/bin/env sh

if [ "$1" = "general" ]; then
    pikaur -S \
        fzf \
        gotop \
        terminal-markdown-viewer \
        python2-pygments \
        nodejs-commitizen \
        nodejs-cz-conventional-changelog \
        pastebinit \
        tcping
    sudo pacman -S ranger atool elinks ffmpegthumbnailer highlight odt2txt perl-image-exiftool
    pikaur -S qv2ray-dev-git qv2ray-plugin-command-dev-git qv2ray-plugin-ssr-dev-git qv2ray-plugin-trojan-dev-git
elif [ "$1" = "physical" ]; then
    pikaur -S fontweak persepolis code typora iw ppet-bin
    sudo pacman -S wine
    sudo pacman -S xsettingsd deepin.com.qq.office
    echo "https://github.com/countstarlight/deepin-wine-tim-arch/issues/1"
    echo 'snippet-add tim         "xsettingsd &"'
    sudo pacman -S wps-office-cn
    pikaur -S ttf-wps-fonts wps-office-mime-cn wps-office-mui-zh-cn
    echo "ttf-ms"
# elif [ "$1" = "wsl" ]; then
fi
