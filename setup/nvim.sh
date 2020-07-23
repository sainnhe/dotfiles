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
    echo "installing boost..."
    pacman -S --noconfirm boost &>/dev/null
    echo "installing words..."
    pacman -S --noconfirm words &>/dev/null
    echo "installing python-wcwidth..."
    pacman -S --noconfirm python-wcwidth &>/dev/null
    echo "installing clang..."
    pacman -S --noconfirm clang &>/dev/null
    echo "installing ccls..."
    pacman -S --noconfirm ccls &>/dev/null
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
    echo "installing pycodestyle..."
    pacman -S --noconfirm python-pycodestyle python2-pycodestyle &>/dev/null
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
    echo "installing zenity..."
    pacman -S --noconfirm zenity &>/dev/null
}
# }}}
# {{{pikaur_setup_func()
pikaur_setup_func() {
    echo -n "make sure you have configured makepkg proxy correctly. [enter to continue]  "
    read -r
    pikaur -S ruby-neovim global stylelint stylelint-config-standard nodejs-jsonlint js-beautify universal-ctags-git
    # echo -n "install global from AUR. [enter to continue]  "
    # read -r
    # pikaur -S global
    # echo -n "install stylelint from AUR. [enter to continue]  "
    # read -r
    # pikaur -S stylelint
    # echo -n "install stylelint-config-standard from AUR. [enter to continue]  "
    # read -r
    # pikaur -S stylelint-config-standard
    # echo -n "install nodejs-jsonlint from AUR. [enter to continue]  "
    # read -r
    # pikaur -S nodejs-jsonlint
    # echo -n "install js-beautify from AUR. [enter to continue]  "
    # read -r
    # pikaur -S js-beautify
    # echo -n "install universal-ctags-git from AUR. [enter to continue]  "
    # read -r
    # pikaur -S universal-ctags-git
}
# }}}
rust_setup() { #{{{
    sudo pacman -S rustup
    proxychains -q rustup install nightly
    rustup default nightly
    proxychains -q rustup component add rust-analyzer-preview rust-analysis rust-src rustfmt
}
# }}}
if [ "$1" = "pacman" ]; then
    pacman_setup_func
elif [ "$1" = "pikaur" ]; then
    pikaur_setup_func
elif [ "$1" = "rust" ]; then
    rust_setup
elif [ "$1" = "dotfiles" ]; then
    cp /home/sainnhe/repo/dotfiles/.vimrc ~/
    mkdir -p ~/.config/nvim
    ln -s /home/sainnhe/repo/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
    ln -s /home/sainnhe/repo/dotfiles/.config/nvim/tasks.ini ~/.config/nvim/tasks.ini
    cp /home/sainnhe/repo/dotfiles/.config/nvim/env.vim ~/.config/nvim/env.vim
    ln -s /home/sainnhe/repo/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
    ln -s /home/sainnhe/repo/dotfiles/.local/share/nvim/snippets ~/.local/share/nvim/snippets
    ln -s /home/sainnhe/repo/dotfiles/.config/nvim/doc ~/.config/nvim/doc
elif [ "$1" = "other" ]; then
    go get -u github.com/high-moctane/nextword
    mkdir -p ~/.local/share/nextword
    cd ~/.local/share/nextword || exit
    proxychains -q wget https://github.com/high-moctane/nextword-data/archive/large.zip
    unzip large.zip
    rm large.zip
elif [ "$1" = "fonts" ]; then
    mkdir -p ~/repo
    git clone git@github.com:sainnhe/icursive-nerd-font-non-free.git ~/repo/icursive-nerd-font-non-free
    git clone git@github.com:sainnhe/icursive-nerd-font.git ~/repo/icursive-nerd-font
    mkdir -p ~/.local/share/fonts
    cp ~/repo/icursive-nerd-font/Fira\ Code\ iCursive\ S12/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font/Roboto\ Mono\ iCursive\ Pt/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font/InconsolataGo\ iCursive\ Pb/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font/InconsolataLGC\ iCursive\ S12/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font/Meslo\ iCursive\ S12/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font/Hack\ iCursive\ S12/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font/Source\ Code\ Pro\ iCursive\ S12/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Cartograph\ Mono/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Ellograph\ Mono/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Dank\ Mono/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Operator\ Mono/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Fira\ Code\ iCursive\ Op/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/InconsolataLGC\ iCursive\ Op/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Meslo\ iCursive\ Op/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Hack\ iCursive\ Op/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Fantasque\ iCursive\ Op/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Fantasque\ iCursive\ Dk/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Source\ Code\ Pro\ iCursive\ Op/* ~/.local/share/fonts/
    cp ~/repo/icursive-nerd-font-non-free/Cascadia\ Code\ iCursive\ Cg/* ~/.local/share/fonts/
    fc-cache
fi
