FROM docker.io/library/alpine:edge
RUN apk update && apk upgrade && apk add \
        shadow \
        bash \
        util-linux \
        ncurses-terminfo \
        mandoc \
        man-pages \
        man-pages-posix \
        ntfs-3g \
        ntfs-3g-progs \
        git \
        subversion \
        curl \
        wget \
        net-tools \
        nmap \
        openssh \
        w3m \
        aria2 \
        tar \
        xz \
        gzip \
        zip \
        unzip \
        fd \
        exa \
        dust \
        ripgrep \
        neofetch \
        socat \
        tcpdump \
        rsync \
        subversion \
        sysbench \
        hyperfine \
        onefetch \
        bottom \
        nnn \
        lua \
        zsh \
        tmux \
        fzf \
        vim \
        neovim \
        helix \
        tree-sitter-grammars \
        make \
        cmake \
        autoconf \
        automake \
        pkgconf \
        bison \
        binutils \
        patch \
        gettext \
        texinfo \
        gcc \
        g++ \
        gdb \
        clang \
        clang-extra-tools \
        nodejs \
        nodejs-dev \
        nodejs-doc \
        npm \
        npm-doc \
        yarn \
        python3 \
        py3-pip \
        py3-requests \
        && npm install -g pnpm \
        && pip install cmake-language-server

RUN git clone --depth=1 https://github.com/sainnhe/dotfiles ~/repo/dotfiles \
        && cp ~/repo/dotfiles/.gitconfig ~ \
        && cp ~/repo/dotfiles/.gitignore_global ~ \
        && cp -r ~/repo/dotfiles/.w3m ~ \
        && cp -r ~/repo/dotfiles/.aria2 ~

# Zsh
RUN ln -s /root/repo/dotfiles/.zshrc ~/.zshrc \
        && ln -s /root/repo/dotfiles/.zsh-snippets ~/.zsh-snippets \
        && cp ~/repo/dotfiles/.zsh-theme/edge-dark.zsh ~/.zsh-theme \
        && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin \
        && zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true ' \
        && zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true '

# Tmux
RUN git clone --depth=1 https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm \
        && cp ~/repo/dotfiles/.tmux.conf ~ \
        && ln -s /root/repo/dotfiles/.tmux/tmuxline ~/.tmux/tmuxline \
        && tmux start-server \
        && tmux new-session -d \
        && sleep 1 \
        && ~/.tmux/plugins/tpm/scripts/install_plugins.sh \
        && tmux kill-server

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup-init \
        && sh rustup-init --default-toolchain nightly --component rust-analyzer-preview rust-docs -y \
        && rm rustup-init

# Vim/Neovim
RUN mkdir -p ~/.config ~/.local/share/nvim \
        && ln -s /root/repo/dotfiles/.config/nvim ~/.vim \
        && ln -s /root/repo/dotfiles/.config/nvim ~/.config/nvim \
        && cp /root/repo/dotfiles/.config/nvim/envs.example.vim /root/repo/dotfiles/.config/nvim/envs.vim
# Coc Extensions
RUN mkdir -p ~/.local/share/nvim/coc/extensions \
        && cd ~/.local/share/nvim/coc/extensions \
        && cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} npm install --ignore-scripts --no-lockfile --production --no-global --legacy-peer-deps {}; exit 0
RUN cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} sh -c "cd ~/.local/share/nvim/coc/extensions/node_modules/{}; npm install --ignore-scripts --no-lockfile --production --no-global --legacy-peer-deps"; exit 0
# Plugins
RUN nvim -es --cmd 'call custom#plug#install()' --cmd 'qa' \
        && CONTAINER=1 nvim --headless +PlugInstall +qall \
        && CONTAINER=1 nvim --headless +"helptags ALL" +qall
# Tree-sitter
RUN nvim --headless +"TSInstallSync all" +qall

# Finalize
RUN rm -rf /var/cache/apk \
        && rm -rf /root/.cache/pip \
        && rm -rf ~/.cache/yarn \
        && rm -rf ~/.npm \
        && rm -rf ~/.cargo/git ~/.cargo/registry \
        && rm -rf ~/bin \
        && mkdir ~/work
WORKDIR /root/work
CMD [ "/bin/zsh" ]
