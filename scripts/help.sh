#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
NC='\033[0m'

printf "${BYELLOW}[n]${BGREEN} Notes (default)     ${BYELLOW}[m]${BGREEN} Manual     ${BYELLOW}[a]${BGREEN} Arch Wiki${NC}\n"
read -r var
if [ "$var"x == ""x ]; then
    var="n"
fi

if [ "$var"x == "n"x ]; then
    cd ~/repo/notes
    filename=$(find . -name "*.md" | sed 's/^..//' | fzf )
    printf "${BYELLOW}[v]${BGREEN} Vim (default)     ${BYELLOW}[t]${BGREEN} Typora${NC}\n"
    read -r var
    if [ "$var"x == ""x ]; then
        var="v"
    fi
    if [ "$var"x == "v"x ]; then
        nvim "$HOME/repo/notes/$filename"
    elif [ "$var"x == "t"x ]; then
        typora "$HOME/repo/notes/$filename"
    fi
elif [ "$var"x == "m"x ]; then
    wikiman -l zh,en -s man
elif [ "$var"x == "a"x ]; then
    wikiman -l zh-CN,en -s arch -H xdg-open
fi
