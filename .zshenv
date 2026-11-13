# {{{XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
# }}}
# {{{Path
# Remove duplicates
typeset -U path PATH manpath MANPATH fpath FPATH

# MacPorts
if [[ "$OSTYPE" == darwin* && -x "/opt/local/bin/port" ]]; then
    export MACPORTS_PREFIX="/opt/local"
    path=(
        "${MACPORTS_PREFIX}/bin"
        "${MACPORTS_PREFIX}/sbin"
        "/opt/podman/bin"(N-/)
        $path
    )
    manpath=(
        "${MACPORTS_PREFIX}/share/man"(N-/)
        $manpath
    )
    fpath=(
        "${MACPORTS_PREFIX}/share/zsh/site-functions"(N-/)
        $fpath
    )
    export INFOPATH="${MACPORTS_PREFIX}/share/info:${INFOPATH}"
    export CPATH="${MACPORTS_PREFIX}/include:${CPATH}"
    export LIBRARY_PATH="${MACPORTS_PREFIX}/lib:${LIBRARY_PATH}"
    export PKG_CONFIG_PATH="${MACPORTS_PREFIX}/lib/pkgconfig:/opt/local/share/pkgconfig:${PKG_CONFIG_PATH}"
    export OPENSSL_ROOT_DIR="${MACPORTS_PREFIX}"
fi

# User level path
path=(
    "$HOME/.local/bin"(N-/)
    "$HOME/bin"(N-/)
    "$HOME/.cargo/bin"(N-/)
    "$HOME/go/bin"(N-/)
    "$HOME/.yarn/bin"(N-/)
    "$HOME/.local/share/pnpm"(N-/)
    "$HOME/.bun/bin"(N-/)
    "$HOME/node_modules/.bin"(N-/)
    "$HOME/.antigravity/antigravity/bin"(N-/)
    $path
)

# Asdf
if (( $+commands[asdf] )); then
    export ASDF_DIR="$HOME/.local/share/asdf"
    export ASDF_DATA_DIR="$ASDF_DIR"
    path=("$ASDF_DATA_DIR/shims"(N-/) $path)
    if [[ -f "${ASDF_DIR}/plugins/java/set-java-home.zsh" ]]; then
        source "${ASDF_DIR}/plugins/java/set-java-home.zsh"
    fi
fi

# Trailing colon
[[ -n "$MANPATH" && "$MANPATH" != *: ]] && export MANPATH="${MANPATH}:"
# }}}
# {{{Editor & Pager
export LESS="-FRX"
export LESSHISTFILE="-"
if (( $+commands[vim] )); then
    export EDITOR="vim"
    export PAGER="vim --cmd 'let g:vim_pager = 1' -c PAGER -"
    export MANPAGER="vim --cmd 'let g:vim_pager = 1' -c ASMANPAGER -"
fi
# }}}
# {{{Dev & CLI Tools
# FZF
if (( $+commands[fzf] )); then
    export FZF_DEFAULT_COMMAND='fd . --type=file --hidden'
    export FZF_DEFAULT_OPTS="
--multi
--height=50%
--layout=reverse
--prompt='❯ '
--ansi
--tabstop=4
--style=full
--color=dark,fg+:2:bold,selected-fg:1:bold,bg+:-1,hl:4,hl+:4:bold,gutter:0,info:3:bold,border:0,prompt:2,pointer:2,marker:1,header:6
--bind=tab:down,btab:up,ctrl-s:toggle,ctrl-p:toggle-preview
--separator=
"
fi

# Go
if (( $+commands[go] )); then
    export GOPATH="$HOME/go"
    export GO111MODULE=on
fi

# Python
if (( $+commands[python] || $+commands[python3] )); then
    export PYTHONPYCACHEPREFIX="$HOME/.cache/pycache"
    export VIRTUAL_ENV_DISABLE_PROMPT=1
fi

# Dotnet
if (( $+commands[dotnet] )); then
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
fi

# Pspg
if (( $+commands[pspg] )); then
    export PSQL_PAGER='pspg -s s --no-topbar'
fi
# }}}
# vim: set fdm=marker fmr={{{,}}}:
