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
        shellcheck

RUN git clone --depth=1 https://github.com/sainnhe/dotfiles

RUN chsh -s /usr/bin/zsh
RUN cp dotfiles/.zshrc ~
RUN cp dotfiles/.zsh-snippets ~
RUN cp dotfiles/.zsh-theme/everforest-dark.zsh ~/.zsh-theme

RUN git clone --depth=1 https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
RUN cp dotfiles/.tmux.conf ~
RUN cp -r dotfiles/.tmux/tmuxline ~/.tmux/tmuxline
# TODO: Install plugins

RUN mkdir -p ~/.config ~/.local/share/nvim
RUN cp -r dotfiles/.config/nvim ~/.config/nvim
RUN ln -s /root/.config/nvim ~/.vim
RUN cp -r dotfiles/.local/share/nvim/snippets ~/.local/share/nvim/snippets
# TODO: Install plugins
# https://github.com/junegunn/vim-plug/issues/225
# Possible solution: nvim --headless +PlugInstall +qall

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init
RUN sh rustup-init --default-toolchain nightly --component rust-analyzer-preview rust-docs -y
RUN cp -r dotfiles/.cargo ~
RUN zsh -c "cargo install cargo-cache lsd && cargo install --all-features --git=https://github.com/latex-lsp/texlab --locked && cargo cache -a"
# TODO: Install plugins
# https://github.com/zdharma-continuum/zinit-configs/blob/master/Dockerfile
# Possible solution: RUN SHELL=/bin/zsh zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true '

RUN rm -rf dotfiles
RUN rm rustup-init

RUN mkdir ~/work
