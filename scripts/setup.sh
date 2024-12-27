#!/usr/bin/env sh

DOTFILES_DIR=$(git rev-parse --show-toplevel)

_help() {
    echo "Usage:"
    echo "./setup.sh ssh your_email@domain.tld"
    echo "./setup.sh git"
    echo "./setup.sh deps"
    echo "./setup.sh rust"
    echo "./setup.sh node"
    echo "./setup.sh python"
    echo "./setup.sh go"
    echo "./setup.sh java"
    echo "./setup.sh typst"
    echo "./setup.sh tmux"
}

# Util Func{{{
_symlink() {
    if [[ "$1" == *"/"* ]]; then
        DIR=$(echo "$1" | grep -o ".*\/")
        mkdir -p "$HOME/$DIR"
    fi
    ln -sf "$DOTFILES_DIR/$1" "$HOME/$1"
}

_copy() {
    if [[ "$1" == *"/"* ]]; then
        DIR=$(echo "$1" | grep -o ".*\/")
        mkdir -p "$HOME/$DIR"
    fi
    cp -rf "$DOTFILES_DIR/$1" "$HOME/$1"
}
#}}}

_ssh() {
    _copy .ssh/config
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -C "$1"
    ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -C "$1"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_ecdsa
}

_git() {
    _copy .gitconfig
    _symlink .gitignore_global
    sudo port -N install git git-lfs cloudflared
    echo "Run ./gnupg.sh to setup gpg"
}

_deps() {
    sudo port -N install \
        # General
        bottom \
        dust \
        fd \
        fzf \
        gnupg2 \
        hyperfine \
        lsd \
        nnn \
        onefetch \
        rclone \
        ripgrep \
        rsync \
        socat \
        tcpdump \
        # Dev env
        vim \
        neovim \
        tmux \
        # Other dev deps
        marksman \
        shellcheck \
        shfmt
}

_rust() {
    _copy .cargo/config.toml
    sudo port -N install cargo rust-analyzer
    cargo install \
        cargo-update \
        cargo-cache \
        protols
}

_node() {
    _copy .npmrc
    _copy .yarnrc
    _symlink package.json
    sudo port -N install \
        nodejs20 \
        npm10 \
        yarn \
        pnpm
    echo "!!! Make sure to modify the cache dir in ~/.npmrc"
    echo "!!! To install required commands: cd ~ && pnpm install"
}

_python() {
    _copy .config/pip/pip.conf
    sudo port -N install \
        py-pip \
        py310-pip \
        py312-pip \
        py312-requests \
        python310 \
        python312 \
        ruff
}

_go() {
    _symlink .golangci.yml
    sudo port -N install \
        go \
        golangci-lint \
        staticcheck \
        revive \
        gopls \
        protobuf3-cpp
    go install go.uber.org/mock/mockgen@latest
    go install github.com/golang/protobuf/protoc-gen-go@latest
    go install github.com/sqls-server/sqls@latest
    echo "Be sure to update ~/.zprofile with envs in $DOTFILES_DIR/.zprofile"
}

_java() {
    sudo port -N install \
        pmd \
        openjdk21-openj9 \
        openjdk21-zulu \
        maven3 \
        gradle
    echo "Be sure to update ~/.zprofile with envs in $DOTFILES_DIR/.zprofile"
}

_typst() {
    sudo port -N install typst
    cargo install --git https://github.com/Myriad-Dreamin/tinymist --locked tinymist
    cargo install typstyle
}

_vim() {
    _symlink .config/nvim
    ln -s "$DOTFILES_DIR/.config/nvim" ~/.vim
    nvim
}

_zsh() {
    _symlink .zshrc
    cp "$DOTFILES_DIR/.zsh-theme/edge-dark.zsh" ~/.zsh-theme
}

_tmux() {
    git clone --depth=1 https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm \
        && cp "$DOTFILES_DIR"/.tmux.conf ~ \
        && ln -s "$DOTFILES_DIR"/.tmux/tmuxline ~/.tmux/tmuxline \
        && tmux start-server \
        && tmux new-session -d \
        && sleep 1 \
        && ~/.tmux/plugins/tpm/scripts/install_plugins.sh \
        && tmux kill-server
}

_dotfiles() {
    _symlink .aria2
    _symlink .config/fcitx5
    _symlink .config/fontconfig
    _symlink .config/helix
    _copy .config/zathura
    _symlink .w3m
    echo "Setup ~/.zsh_envs.d manually"
} #}}}

if [ "$1" = "help" ]; then
    _help
elif [ "$1" = "ssh" ]; then
    _ssh "$2"
elif [ "$1" = "git" ]; then
    _git
elif [ "$1" = "deps" ]; then
    _deps
elif [ "$1" = "rust" ]; then
    _rust
elif [ "$1" = "node" ]; then
    _node
elif [ "$1" = "python" ]; then
    _python
elif [ "$1" = "go" ]; then
    _go
elif [ "$1" = "java" ]; then
    _java
elif [ "$1" = "typst" ]; then
    _typst
elif [ "$1" = "vim" ]; then
    _vim
elif [ "$1" = "zsh" ]; then
    _zsh
elif [ "$1" = "tmux" ]; then
    _tmux
elif [ "$1" = "dotfiles" ]; then
    _dotfiles
fi

# vim: set tabstop=4 fdm=marker fmr={{{,}}}:
