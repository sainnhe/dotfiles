# syntax=docker/dockerfile:experimental

# Build: docker build -t sainnhe/dotfiles .
# Run:   docker run -v <workdir-on-local-machine>:/root/work -it sainnhe/dotfiles zsh

FROM debian:latest
RUN apt update && apt upgrade
RUN apt install -y \
        git \
        gcc \
        gdb \
        curl \
        lua5.4 \
        zsh \
        tmux \
        python3-requests \
        vim \
        neovim \
        nodejs \
        npm \
        yarnpkg \
        clangd \
        ripgrep \
        julia \
        texlive \
        shellcheck \
        fzf

RUN \
        git clone --depth=1 https://github.com/sainnhe/dotfiles ~/repo/dotfiles && \
        cp ~/repo/dotfiles/.gitconfig ~ && \
        cp ~/repo/dotfiles/.gitignore_global ~

# Zsh
RUN \
        chsh -s /usr/bin/zsh && \
        ln -s /root/repo/dotfiles/.zshrc ~/.zshrc && \
        ln -s /root/repo/dotfiles/.zsh-snippets ~/.zsh-snippets && \
        cp ~/repo/dotfiles/.zsh-theme/edge-dark.zsh ~/.zsh-theme
RUN git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
SHELL ["/usr/bin/zsh", "-c"]
RUN source ~/.zshrc
RUN zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true '

# Tmux
RUN \
        git clone --depth=1 https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm && \
        cp ~/repo/dotfiles/.tmux.conf ~ && \
        ln -s /root/repo/dotfiles/.tmux/tmuxline ~/.tmux/tmuxline
RUN \
        tmux start-server && \
        tmux new-session -d && \
        sleep 1 && \
        ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
        tmux kill-server

# Rust
RUN \
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init && \
        sh rustup-init --default-toolchain nightly --component rust-analyzer-preview rust-docs -y && \
        rm rustup-init && \
        cp -r ~/repo/dotfiles/.cargo ~ && \
        zsh -c "cargo install lsd"

# Vim/Neovim
RUN \
        mkdir -p ~/.config ~/.local/share/nvim && \
        ln -s /root/repo/dotfiles/.config/nvim ~/.vim && \
        ln -s /root/repo/dotfiles/.config/nvim ~/.config/nvim && \
        ln -s /root/repo/dotfiles/.local/share/nvim/snippets ~/.local/share/nvim/snippets && \
        cp ~/.vim/envs.example.vim ~/.vim/envs.vim
# TODO: Install plugins
# https://github.com/junegunn/vim-plug/issues/225
# https://github.com/neoclide/coc.nvim/issues/118
# Possible solution: nvim --headless +PlugInstall +qall
# RUN timeout 1m nvim --headless +CocInstall; exit 0
# nvim --headless +"CocInstall -sync $extensions|qa"

RUN mkdir ~/work
