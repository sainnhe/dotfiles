FROM public.ecr.aws/docker/library/alpine:edge
RUN echo '@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
        && apk upgrade --no-cache && apk add --no-cache \
        # Basic packages
        bash \
        man-pages \
        man-pages-posix \
        mandoc \
        ncurses-terminfo \
        shadow \
        file \
        # Utilities
        bottom \
        dust \
        fd \
        fzf \
        gnupg \
        gzip \
        hyperfine \
        lsd@testing \
        nnn \
        ntfs-3g \
        ntfs-3g-progs \
        onefetch \
        openssh \
        pigz \
        ripgrep \
        sysstat \
        tar \
        tealdeer@testing \
        unzip \
        util-linux \
        viu \
        xz \
        zip \
        # Network
        aria2 \
        axel \
        bind-tools \
        curl \
        inetutils-ftp \
        inetutils-syslogd-openrc \
        inetutils-telnet \
        lsof \
        net-tools \
        nmap \
        rclone \
        rsync \
        socat \
        tcpdump \
        traceroute \
        w3m \
        wget \
        # Development
        flex \
        git \
        git-lfs \
        neovim \
        openssl \
        openssl-dev \
        shellcheck \
        shfmt \
        tmux \
        vim \
        zsh \
        # Build tools
        autoconf \
        automake \
        binutils \
        bison \
        cmake \
        gettext \
        make \
        patch \
        pkgconf \
        texinfo \
        # C/C++
        clang \
        clang-extra-tools \
        g++ \
        gcc \
        gdb \
        # Go
        go \
        golangci-lint \
        gopls \
        protobuf \
        staticcheck \
        # Rust
        rust \
        cargo \
        rust-analyzer \
        # Python
        py3-pip \
        py3-pynvim \
        py3-requests \
        python3 \
        python3-dev \
        ruff \
        ruff@testing \
        # Node
        nodejs \
        nodejs-dev \
        nodejs-doc \
        npm \
        npm-doc \
        pnpm@testing \
        yarn \
        # Java
        maven \
        openjdk21 \
        # Typst
        typst \
        && [ "$(uname -m)" = "x86_64" ] \
        && curl -fSL \
        -o /usr/bin/marksman \
        https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 \
        || curl -fSL \
        -o /usr/bin/marksman \
        https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-arm64 \
        && chmod a+x /usr/bin/marksman

RUN git clone --depth=1 https://github.com/sainnhe/dotfiles ~/repo/dotfiles \
        && cp ~/repo/dotfiles/.gitconfig ~ \
        && cp ~/repo/dotfiles/.gitignore_global ~/.gitignore \
        && cp -r ~/repo/dotfiles/.w3m ~ \
        && cp -r ~/repo/dotfiles/.aria2 ~

# Zsh
RUN cp ~/repo/dotfiles/.zshrc ~/.zshrc \
        && cp ~/repo/dotfiles/.zsh-theme/edge-dark.zsh ~/.zsh-theme \
        && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin \
        && zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true ' \
        && zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true ' \
        && passwd -d root \
        && chsh -s /bin/zsh \
        && rm -rf ~/.zinit/plugins/*/.git

# Tmux
RUN git clone --depth=1 https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm \
        && cp ~/repo/dotfiles/.tmux.conf ~ \
        && cp -r ~/repo/dotfiles/.tmux/tmuxline ~/.tmux/tmuxline \
        && tmux start-server \
        && tmux new-session -d \
        && sleep 1 \
        && ~/.tmux/plugins/tpm/scripts/install_plugins.sh \
        && tmux kill-server

# Vim/Neovim
RUN mkdir -p ~/.config ~/.local/share/nvim \
        && ln -s /root/repo/dotfiles/.config/nvim ~/.vim \
        && ln -s /root/repo/dotfiles/.config/nvim ~/.config/nvim \
        && cp ~/repo/dotfiles/.config/nvim/envs.container.vim ~/repo/dotfiles/.config/nvim/envs.vim
# Coc Extensions
RUN mkdir -p ~/.local/share/nvim/coc/extensions \
        && cd ~/.local/share/nvim/coc/extensions \
        && cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} npm install --ignore-scripts --no-lockfile --production --no-global --legacy-peer-deps {}; exit 0 \
        && rm -rf ~/.npm \
        && ls ~/.local/share/nvim/coc/extensions/node_modules | grep -v 'coc-' | xargs -I{} rm -rf ~/.local/share/nvim/coc/extensions/node_modules/{}
RUN cat ~/.config/nvim/features/full.vim |\
        grep "\\\ 'coc-" |\
        sed -E -e 's/^.*coc//' -e "s/',//" -e 's/^/coc/' |\
        xargs -I{} sh -c "cd ~/.local/share/nvim/coc/extensions/node_modules/{}; npm install --ignore-scripts --no-lockfile --production --no-global --legacy-peer-deps"; exit 0 \
        && rm -rf ~/.npm \
        && ls ~/.local/share/nvim/coc/extensions/node_modules | grep -v 'coc-' | xargs -I{} rm -rf ~/.local/share/nvim/coc/extensions/node_modules/{}
# Plugins
RUN nvim -es --cmd 'call custom#plug#install()' --cmd 'qa' \
        && CONTAINER=1 nvim --headless +PlugInstall +qall \
        && CONTAINER=1 nvim --headless +"helptags ALL" +qall \
        && rm -rf ~/.local/share/nvim/plugins/*/node_modules \
        && rm -rf ~/.cache/yarn \
        && rm -rf ~/.npm \
        && rm -rf ~/.local/share/pnpm
# Tree-sitter
RUN nvim --headless +"TSInstallSync all" +qall

# Finalize
RUN rm -rf ~/bin \
        && mkdir ~/work
WORKDIR /root/work
CMD [ "/bin/zsh" ]
