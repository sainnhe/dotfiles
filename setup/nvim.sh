#!/bin/env bash

# {{{pacman_setup_func()
pacman_setup_func() {
    echo -n "make sure you have configured proxy and locale correctly. [enter to continue]  "
    read -r
    sudo pacman -Sy
    sudo pacman -S \
        neovim \
        python \
        python2 \
        python-pynvim \
        python2-neovim \
        python-pip \
        python2-pip \
        boost \
        words \
        python-wcwidth \
        clang \
        ccls \
        tidy \
        python-jedi \
        python-pylint python2-pylint \
        flake8 python2-flake8 \
        mypy \
        python-pycodestyle python2-pycodestyle \
        python-pydocstyle python2-pydocstyle \
        flawfinder \
        cppcheck \
        shellcheck \
        vint \
        astyle \
        prettier \
        shfmt \
        uncrustify \
        yapf \
        zenity
}
# }}}
# {{{pikaur_setup_func()
pikaur_setup_func() {
    echo -n "make sure you have configured the proxy of makepkg and pikaur correctly. [enter to continue]  "
    read -r
    pikaur -S \
        ruby-neovim \
        global \
        stylelint \
        stylelint-config-standard \
        nodejs-jsonlint \
        js-beautify \
        universal-ctags-git \
        pylance-language-server
}
# }}}
rust_setup() { #{{{
    sudo pacman -S rustup
    proxychains -q rustup install nightly
    rustup default nightly
    proxychains -q rustup component add \
        rust-analyzer-preview \
        rust-analysis \
        rust-src \
        rustfmt
}
# }}}
#{{{ $ bash setup/nvim.sh pacman/pikaur/rust/dotfiles/other/fonts
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
#}}}
