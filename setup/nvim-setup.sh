#!/bin/env bash

# {{{pacman_setup_func()
pacman_setup_func() {
    echo -n "make sure you have configured proxy and locale correctly. [enter to continue]  "
    read -r
    echo "updating cache..."
    pacman -Syy &>/dev/null
    echo "setting up python provider..."
    pacman -S --noconfirm python python2 &>/dev/null
    pacman -S --noconfirm python-pynvim &>/dev/null
    pacman -S --noconfirm python2-neovim &>/dev/null
    pacman -S --noconfirm python-pip python2-pip &>/dev/null
    echo "installing npm..."
    pacman -S --noconfirm npm &>/dev/null
    echo "installing yarn..."
    pacman -S --noconfirm yarn &>/dev/null
    echo "installing go..."
    pacman -S --noconfirm go &>/dev/null
    echo "installing lua..."
    pacman -S --noconfirm lua &>/dev/null
    echo "installing nnn..."
    pacman -S --noconfirm nnn &>/dev/null
    echo "installing boost..."
    pacman -S --noconfirm boost &>/dev/null
    echo "installing xclip..."
    pacman -S --noconfirm xclip &>/dev/null
    echo "installing words..."
    pacman -S --noconfirm words &>/dev/null
    echo "installing the_silver_searcher..."
    pacman -S --noconfirm the_silver_searcher &>/dev/null
    echo "installing ripgrep..."
    pacman -S --noconfirm ripgrep &>/dev/null
    echo "installing python-wcwidth..."
    pacman -S --noconfirm python-wcwidth &>/dev/null
    echo "installing languagetool..."
    pacman -S --noconfirm languagetool &>/dev/null
    echo "installing clang..."
    pacman -S --noconfirm clang &>/dev/null
    echo "installing tidy..."
    pacman -S --noconfirm tidy &>/dev/null
    echo "installing jedi..."
    pacman -S --noconfirm python-jedi &>/dev/null
    echo "installing pylint..."
    pacman -S --noconfirm python-pylint python2-pylint &>/dev/null
    echo "installing flake8..."
    pacman -S --noconfirm flake8 python2-flake8 &>/dev/null
    echo "installing mypy..."
    pacman -S --noconfirm mypy &>/dev/null
    echo "installing pydocstyle..."
    pacman -S --noconfirm python-pydocstyle python2-pydocstyle &>/dev/null
    echo "installing flawfinder..."
    pacman -S --noconfirm flawfinder &>/dev/null
    echo "installing cppcheck..."
    pacman -S --noconfirm cppcheck &>/dev/null
    echo "installing shellcheck..."
    pacman -S --noconfirm shellcheck &>/dev/null
    echo "installing vint..."
    pacman -S --noconfirm vint &>/dev/null
    echo "installing astyle..."
    pacman -S --noconfirm astyle &>/dev/null
    echo "installing prettier..."
    pacman -S --noconfirm prettier &>/dev/null
    echo "installing shfmt..."
    pacman -S --noconfirm shfmt &>/dev/null
    echo "installing uncrustify..."
    pacman -S --noconfirm uncrustify &>/dev/null
    echo "installing yapf..."
    pacman -S --noconfirm yapf &>/dev/null
    echo "installing python-language-server..."
    pacman -S --noconfirm python-language-server &>/dev/null
    echo "installing bash-language-server..."
    pacman -S --noconfirm bash-language-server &>/dev/null
    echo "installing hasktags..."
    pacman -S --noconfirm hasktags &>/dev/null
    echo "installing zenity..."
    pacman -S --noconfirm zenity &>/dev/null
}
# }}}
# {{{pikaur_setup_func()
pikaur_setup_func() {
    echo -n "make sure you have configured makepkg proxy correctly. [enter to continue]  "
    read -r
    echo -n "install microsoft-python-language-server from AUR. [enter to continue]  "
    read -r
    pikaur -S microsoft-python-language-server
    echo -n "install javascript-typescript-langserver from AUR. [enter to continue]  "
    read -r
    pikaur -S javascript-typescript-langserver
    echo -n "install yaml-language-server-bin from AUR. [enter to continue]  "
    read -r
    pikaur -S yaml-language-server-bin
    echo -n "install global from AUR. [enter to continue]  "
    read -r
    pikaur -S global
    echo -n "install toilet from AUR. [enter to continue]  "
    read -r
    pikaur -S toilet
    echo -n "install toilet-fonts from AUR. [enter to continue]  "
    read -r
    pikaur -S toilet-fonts
    echo -n "install stylelint from AUR. [enter to continue]  "
    read -r
    pikaur -S stylelint
    echo -n "install stylelint-config-standard from AUR. [enter to continue]  "
    read -r
    pikaur -S stylelint-config-standard
    echo -n "install nodejs-jsonlint from AUR. [enter to continue]  "
    read -r
    pikaur -S nodejs-jsonlint
    echo -n "install js-beautify from AUR. [enter to continue]  "
    read -r
    pikaur -S js-beautify
    echo -n "install universal-ctags-git from AUR. [enter to continue]  "
    read -r
    pikaur -S universal-ctags-git
    echo -n "install gotags-git from AUR. [enter to continue]  "
    read -r
    pikaur -S gotags-git
    echo -n "install jsctags-tern-git from AUR. [enter to continue]  "
    read -r
    pikaur -S jsctags-tern-git
    echo -n "install markdown2ctags from AUR. [enter to continue]  "
    read -r
    pikaur -S markdown2ctags
    echo -n "install rst2ctags from AUR. [enter to continue]  "
    read -r
    pikaur -S rst2ctags
    echo -n "install cling-git from AUR. [enter to continue]  "
    read -r
    pikaur -S cling-git
}
# }}}
# {{{npm_yarn_setup()
npm_yarn_setup() {
    cd  ~
    echo -n "Use proxychains? [Y/n]  "
    read -r var
    if [[ "$var"x == ""x ]]; then
        var=Y
    fi
    if [[ "$var" == "Y" ]]; then
        proxychains -q npm install --user vscode-html-languageserver-bin
        proxychains -q npm install --user vscode-css-languageserver-bin
        proxychains -q npm install --user vscode-json-languageserver-bin
        proxychains -q yarn add --dev flow-bin
    else
        npm install --user vscode-html-languageserver-bin
        npm install --user vscode-css-languageserver-bin
        npm install --user vscode-json-languageserver-bin
        yarn add --dev flow-bin
    fi
}
# }}}
rust_setup() { #{{{
    sudo pacman -S rustup
    proxychains -q rustup install nightly
    rustup default nightly
    proxychains -q rustup component add rls rust-analysis rust-src rustfmt
}
# }}}
if [ "$1" = "pacman" ]; then
    pacman_setup_func
elif [ "$1" = "pikaur" ]; then
    pikaur_setup_func
elif [ "$1" = "node" ]; then
    npm_yarn_setup
elif [ "$1" = "rust" ]; then
    rust_setup
elif [ "$1" = "dotfiles" ]; then
    cp /home/sainnhe/repo/dotfiles/.vimrc ~/
    mkdir -p ~/.config/nvim
    ln -s /home/sainnhe/repo/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
    ln -s /home/sainnhe/repo/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
fi
