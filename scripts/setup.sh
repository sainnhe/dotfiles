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

_ssh() {
    mkdir -p ~/.ssh
    cp "$DOTFILES_DIR"/.ssh/config ~/.ssh/
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -C "$1"
    ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -C "$1"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_ecdsa
}

_git() {
    sudo port -N install git git-lfs cloudflared
    cp "$DOTFILES_DIR"/.gitconfig ~
    cp "$DOTFILES_DIR"/.gitignore_global ~
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
    sudo port -N install cargo rust-analyzer
    cargo install cargo-update cargo-cache
}

_node() {
    sudo port -N install \
        nodejs20 \
        npm10 \
        yarn \
        pnpm
    cp "$DOTFILES_DIR/.npmrc" ~
    cp "$DOTFILES_DIR/.yarnrc" ~
    ln -s "$DOTFILES_DIR/package.json" ~
    echo "!!! Make sure to modify the cache dir in ~/.npmrc"
    echo "!!! To install required commands: cd ~ && pnpm install"
}

_python() {
    sudo port -N install \
        py-pip \
        py310-pip \
        py312-pip \
        py312-requests \
        python310 \
        python312 \
        ruff
    mkdir -p ~/.config/pip
    cp "$DOTFILES_DIR"/.config/pip/pip.conf ~/.config/pip
}

_go() {
    sudo port -N install \
        go \
        golangci-lint \
        staticcheck \
        revive \
        gopls \
        protobuf3-cpp
    go install go.uber.org/mock/mockgen@latest
    go install github.com/golang/protobuf/protoc-gen-go@latest
    go install github.com/lasorda/protobuf-language-server@latest
    ln -s "$DOTFILES_DIR/.golangci.yml" ~
    echo "Be sure to update ~/.zprofile with envs in $DOTFILES_DIR/.zprofile"
}

_java() {
    sudo port -N install \
        pmd \
        openjdk21-openj9 \
        openjdk21-zulu \
        maven3
    echo "Be sure to update ~/.zprofile with envs in $DOTFILES_DIR/.zprofile"
}

_typst() {
    sudo port -N install typst
    cargo install --git=https://github.com/nvarner/typst-lsp typst-lsp
    cargo install typstyle
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
elif [ "$1" = "tmux" ]; then
    _tmux
fi

# vim: set tabstop=4
