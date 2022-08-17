# Build: podman build -t sainnhe/dotfiles .
# Run:   podman run -v <workdir-on-local-machine>:/root/work -it --rm sainnhe/dotfiles zsh

FROM opensuse/tumbleweed:latest
RUN zypper ref && zypper up -y
RUN zypper in -y \
        shadow \
        git \
        gcc \
        gcc-c++ \
        gdb \
        ntfs-3g \
        wget \
        net-tools \
        traceroute \
        mosh \
        nmap \
        w3m \
        aria2 \
        tar \
        gzip \
        zip \
        unzip \
        findutils \
        fd \
        tealdeer \
        make \
        cmake \
        autoconf \
        automake \
        neofetch \
        hyperfine \
        onefetch \
        bottom \
        nnn \
        pkgconf-pkg-config \
        libstdc++6 \
        libopenssl-devel \
        curl \
        lua54 \
        zsh \
        tmux \
        terminfo \
        fzf \
        vim \
        vim-data \
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
        python310 \
        python310-pip && \
        sync
RUN pip install \
        requests \
        cmake-language-server
RUN npm install -g pnpm

RUN \
        git clone --depth=1 https://github.com/sainnhe/dotfiles ~/repo/dotfiles && \
        cp ~/repo/dotfiles/.gitconfig ~ && \
        cp ~/repo/dotfiles/.gitignore_global ~ && \
        cp -r ~/repo/dotfiles/.w3m ~ && \
        cp -r ~/repo/dotfiles/.aria2 ~

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
        zsh -c "cargo install lsd du-dust rm-improved" && \
        zsh -c "cargo install --all-features --git=https://github.com/latex-lsp/texlab --locked"

# Vim/Neovim
RUN \
        mkdir -p ~/.config ~/.local/share/nvim && \
        ln -s /root/repo/dotfiles/.config/nvim ~/.vim && \
        ln -s /root/repo/dotfiles/.config/nvim ~/.config/nvim && \
        cp ~/.vim/envs.example.vim ~/.vim/envs.vim
RUN \
        mkdir -p ~/.local/share/nvim/coc/extensions && \
        cd ~/.local/share/nvim/coc/extensions && \
        cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} npm install --ignore-scripts --no-lockfile --production --no-global --legacy-peer-deps {}; exit 0
RUN \
        cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} sh -c "cd ~/.local/share/nvim/coc/extensions/node_modules/{}; npm install --ignore-scripts --no-lockfile --production --no-global --legacy-peer-deps"; exit 0
RUN \
        nvim -es --cmd 'call custom#plug#install()' --cmd 'qa' && \
        DOCKER_INIT=1 nvim --headless +PlugInstall +qall && \
        DOCKER_INIT=1 nvim --headless +"helptags ALL" +qall
RUN \
        nvim --headless +"TSInstallSync all" +qall

# Post-install
RUN \
        tldr --update && \
        zypper clean --all && \
        yarn cache clean && \
        npm cache clean --force && \
        rm -rf ~/.cargo/git ~/.cargo/registry && \
        rm -rf ~/bin && \
        mkdir ~/work
