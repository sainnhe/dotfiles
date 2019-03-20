#!/bin/bash
# {{{pacman_setup_func()
pacman_setup_func() {
    echo -n "make sure you have configured proxy and locale correctly. [enter to continue]  "
    read -r
    echo "updating cache..."
    pacman -Syy &> /dev/null
    echo "setting up python provider..."
    pacman -S --noconfirm python python2 &> /dev/null
    pacman -S --noconfirm python-neovim &> /dev/null
    pacman -S --noconfirm python2-neovim &> /dev/null
    pacman -S --noconfirm python-pip python2-pip &> /dev/null
    echo "installing git..."
    pacman -S --noconfirm git &> /dev/null
    echo "installing npm..."
    pacman -S --noconfirm npm &> /dev/null
    echo "installing yarn..."
    pacman -S --noconfirm yarn &> /dev/null
    echo "installing go..."
    pacman -S --noconfirm go &> /dev/null
    echo "installing lua..."
    pacman -S --noconfirm lua &> /dev/null
    echo "installing nnn..."
    pacman -S --noconfirm nnn &> /dev/null
    echo "installing boost..."
    pacman -S --noconfirm boost &> /dev/null
    echo "installing xclip..."
    pacman -S --noconfirm xclip &> /dev/null
    echo "installing words..."
    pacman -S --noconfirm words &> /dev/null
    echo "installing the_silver_searcher..."
    pacman -S --noconfirm the_silver_searcher &> /dev/null
    echo "installing ripgrep..."
    pacman -S --noconfirm ripgrep &> /dev/null
    echo "installing fzf..."
    pacman -S --noconfirm fzf &> /dev/null
    echo "installing ctags..."
    pacman -S --noconfirm ctags &> /dev/null
    echo "installing php..."
    pacman -S --noconfirm php &> /dev/null
    echo "installing python-wcwidth..."
    pacman -S --noconfirm python-wcwidth &> /dev/null
    echo "installing languagetool..."
    pacman -S --noconfirm languagetool &> /dev/null
    echo "installing clang..."
    pacman -S --noconfirm clang &> /dev/null
    echo "installing tidy..."
    pacman -S --noconfirm tidy &> /dev/null
    echo "installing jedi..."
    pacman -S --noconfirm python-jedi &> /dev/null
    echo "installing flake8..."
    pacman -S --noconfirm flake8 &> /dev/null
    echo "installing flawfinder..."
    pacman -S --noconfirm flawfinder &> /dev/null
    echo "installing cppcheck..."
    pacman -S --noconfirm cppcheck &> /dev/null
    echo "installing shellcheck..."
    pacman -S --noconfirm shellcheck &> /dev/null
    echo "installing vint..."
    pacman -S --noconfirm vint &> /dev/null
    echo "installing python-pyflakes..."
    pacman -S --noconfirm python-pyflakes &> /dev/null
    echo "installing python-pycodestyle..."
    pacman -S --noconfirm python-pycodestyle &> /dev/null
    echo "installing python-pydocstyle..."
    pacman -S --noconfirm python-pydocstyle &> /dev/null
    echo "installing python-pylint..."
    pacman -S --noconfirm python-pylint &> /dev/null
    echo "installing astyle..."
    pacman -S --noconfirm astyle &> /dev/null
    echo "installing prettier..."
    pacman -S --noconfirm prettier &> /dev/null
    echo "installing shfmt..."
    pacman -S --noconfirm shfmt &> /dev/null
    echo "installing uncrustify..."
    pacman -S --noconfirm uncrustify &> /dev/null
    echo "installing yapf..."
    pacman -S --noconfirm yapf &> /dev/null
    echo "installing python-language-server..."
    pacman -S --noconfirm python-language-server &> /dev/null
    echo "installing bash-language-server..."
    pacman -S --noconfirm bash-language-server &> /dev/null
}
# }}}
# {{{yay_setup_func()
yay_setup_func() {
    echo -n "make sure you have configured makepkg proxy correctly. [enter to continue]  "
    read -r
    echo -n "install cquery from AUR. [enter to continue]  "
    read -r
    yay -S cquery-git
    echo -n "install ccls from AUR. [enter to continue]  "
    read -r
    yay -S ccls
    echo -n "install mpls from AUR. [enter to continue]  "
    read -r
    yay -S microsoft-python-language-server
    echo -n "install yaml-language-server-bin from AUR. [enter to continue]  "
    read -r
    yay -S yaml-language-server-bin
    echo -n "install global from AUR. [enter to continue]  "
    read -r
    yay -S global
    echo -n "install toilet from AUR. [enter to continue]  "
    read -r
    yay -S toilet
    echo -n "install toilet-fonts from AUR. [enter to continue]  "
    read -r
    yay -S toilet-fonts
    echo -n "install stylelint from AUR. [enter to continue]  "
    read -r
    yay -S stylelint
    echo -n "install nodejs-jsonlint from AUR. [enter to continue]  "
    read -r
    yay -S nodejs-jsonlint
    echo -n "install js-beautify from AUR. [enter to continue]  "
    read -r
    yay -S js-beautify
}
# }}}
# {{{npm_global_setup()
npm_global_setup() {
    npm install -g vscode-html-languageserver-bin
    npm install -g vscode-css-languageserver-bin
    npm install -g vscode-json-languageserver-bin
}
# }}}
# {{{npm_setup()
npm_setup() {
    npm install stylelint-config-standard
    npm install jsonlint
}
# }}}
bash -c "$(declare -f pacman_setup_func); pacman_setup_func"
su sainnhe -c "$(declare -f yay_setup_func); yay_setup_func"
bash -c "$(declare -f npm_global_setup); npm_global_setup"
su sainnhe -c "$(declare -f npm_setup); npm_setup"
printf "\n\ninstall mpls manually\nhttps://microsoft.github.io/language-server-protocol/implementors/servers/\n"
