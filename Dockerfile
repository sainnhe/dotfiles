# syntax=docker/dockerfile:experimental

# Build: docker build -t sainnhe/dotfiles .
# Run:   docker run -v <workdir-on-local-machine>:/root/work -it sainnhe/dotfiles zsh

FROM opensuse/tumbleweed:latest
RUN zypper ref && zypper up -y
RUN zypper in -y \
        git \
        gcc \
        gcc-c++ \
        gdb \
        make \
        pkgconf-pkg-config \
        libstdc++6 \
        libopenssl-devel \
        curl \
        lua54 \
        zsh \
        tar \
        gzip \
        tmux \
        terminfo \
        fzf \
        vim \
        neovim \
        nodejs16 \
        nodejs16-devel \
        nodejs16-docs \
        npm16 \
        yarn \
        clang \
        ripgrep \
        texlive \
        ShellCheck \
        julia \
        python310 \
        python310-pip
RUN pip install \
        requests \
        cmake-language-server
# TODO: texlab

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
        zsh -c "cargo install lsd"

# Vim/Neovim
RUN \
        mkdir -p ~/.config ~/.local/share/nvim && \
        ln -s /root/repo/dotfiles/.config/nvim ~/.vim && \
        ln -s /root/repo/dotfiles/.config/nvim ~/.config/nvim && \
        ln -s /root/repo/dotfiles/.local/share/nvim/snippets ~/.local/share/nvim/snippets && \
        cp ~/.vim/envs.example.vim ~/.vim/envs.vim
RUN \
        git clone --depth=1 https://github.com/neoclide/coc.nvim.git ~/.local/share/nvim/plugins/coc.nvim && \
        cd ~/.local/share/nvim/plugins/coc.nvim && \
        yarn install --frozen-lockfile && \
        mkdir -p ~/.local/share/nvim/coc/extensions && \
        cd ~/.local/share/nvim/coc/extensions && \
        cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} yarn add {}; exit 0
RUN \
        nvim -es --cmd 'call custom#plug#install()' --cmd 'qa' && \
        DOCKER_INIT=1 nvim --headless +PlugInstall +qall && \
        DOCKER_INIT=1 vim +PlugInstall +qall > /dev/null
RUN \
        nvim --headless +"TSInstallSync maintained" +qall

# Post-install
RUN \
        zypper clean --all && \
        yarn cache clean && \
        npm cache clean --force && \
        rm -rf ~/.cargo/git ~/.cargo/registry && \
        mkdir ~/work

