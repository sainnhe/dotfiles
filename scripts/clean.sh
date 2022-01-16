#!/usr/bin/env bash

BBLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

sudo echo ""
printf "${GREEN}1) All (Default)${NC}\n"
printf "${GREEN}2) Pacman Packages Cache${NC}\n"
printf "${GREEN}3) AUR Cache${NC}\n"
printf "${GREEN}4) Unneeded Packages${NC}\n"
printf "${GREEN}5) Stubborn Trash Files${NC}\n"
echo ""

read -r num

#Default
if [ "$num"x == ""x ]; then
        num="1"
fi

#Function
function readjudge() {
        echo ""
        printf "${BBLUE}==> Clean? [Y/n]${NC}  "
        read -r judge
        if [ "$judge"x == ""x ]; then
                judge="Y"
        fi
}

#2
if [ "$num" == "1" ] || [ "$num" == "2" ]; then
        echo ""
        printf "${BBLUE}==> Pacman Packages Cache:${NC}\n"
        echo ""
        sudo ls /var/cache/pacman/pkg
        readjudge
        if [ "$judge" == "Y" ]; then
                sudo rm -rf /var/cache/pacman/pkg/*
        fi
fi

#3
if [ "$num" == "1" ] || [ "$num" == "3" ]; then
        echo ""
        printf "${BBLUE}==> AUR Build Cache:${NC}\n"
        echo ""
        ls ~/.cache/pikaur/build/ | grep -v '.*git\>'
        echo ""
        printf "${BBLUE}==> Clean? [Y/n]${NC}  "
        read -r judge
        if [ "$judge"x == ""x ]; then
                judge="Y"
        fi
        if [ "$judge" == "Y" ]; then
            /usr/bin/ls -d -1 "$HOME/.cache/pikaur/build/"* | grep -v '.*git\>' | xargs sudo rm -rf
            /usr/bin/ls -d -1 "$HOME/.local/share/pikaur/aur_repos/"* | grep -v '.*git\>' | xargs sudo rm -rf
        fi
        echo ""
        printf "${BBLUE}==> AUR Packages Cache:${NC}\n"
        echo ""
        ls ~/.cache/pikaur/pkg/
        readjudge
        if [ "$judge" == "Y" ]; then
                rm -rf ~/.cache/pikaur/pkg/*
        fi
fi

#4
if [ "$num" == "1" ] || [ "$num" == "4" ]; then
        pacman -Qdtq | sudo pacman -Rns -
fi

#5
if [ "$num" == "1" ] || [ "$num" == "5" ]; then
        echo ""
        printf "${BBLUE}==> Stubborn Trash Files:${NC}\n"
        echo ""
        ls /home/sainnhe/.local/share/Trash/info
        readjudge
        if [ "$judge" == "Y" ]; then
                ktrash5 --empty
        fi
fi

printf "${BBLUE}==> Launch bleachbit? [N/y]${NC}  "
read -r judge
if [ "$judge"x == "y"x ]; then
        bleachbit --gui
fi
