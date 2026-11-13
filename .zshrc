# zmodload zsh/zprof
# {{{Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}
# {{{Custom Envs
if [[ -d "$HOME/.zshenvs" ]]; then
    for _env in "$HOME/.zshenvs/"*.zsh(N); do
        [[ -r "$_env" ]] && source "$_env"
    done
    unset _env
fi
# }}}
# {{{General
umask 077

# History
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=200000
SAVEHIST=$HISTSIZE

setopt extended_history       # Save timestamp and duration for each command
setopt share_history          # Share history across multiple sessions/panes in real time
setopt hist_ignore_dups       # Ignore consecutive duplicate commands
setopt hist_ignore_all_dups   # Remove older duplicate entries from the history list
setopt hist_save_no_dups      # Do not write duplicate entries to the history file
setopt hist_find_no_dups      # Do not display duplicates when searching history
setopt hist_ignore_space      # Ignore commands starting with a space (useful for secrets)
setopt hist_reduce_blanks     # Remove superfluous blanks from each command

# Navigation & Interaction
DIRSTACKSIZE=20
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
KEYTIMEOUT=1

setopt auto_cd                # Change directory by typing its name without 'cd'
setopt autopushd              # Push the old directory onto the stack on 'cd'
setopt pushd_ignore_dups      # Do not push duplicate directories onto the stack
setopt pushd_silent           # Do not print the directory stack after pushd/popd
setopt interactive_comments   # Allow comments starting with '#' in interactive shells
setopt no_beep                # Disable terminal bell on errors
setopt extended_glob          # Enable advanced glob qualifiers (#, ~, ^) globally
setopt numeric_glob_sort      # Sort filenames numerically (e.g., file2 before file10)
setopt long_list_jobs         # Display PID when suspending or backgrounding jobs
setopt combining_chars        # Properly render NFD Unicode filenames (essential on macOS)

bindkey -e                    # Force Emacs keybindings (prevent EDITOR=vim from enabling vi mode)
# }}}
# {{{Prompt
# Set cursor style to blinking vertical bar
[[ -n "$TTY" && -w "$TTY" ]] && printf '\e[5 q' > "$TTY"
# }}}
# {{{Alias
alias vimdefault="vim -u DEFAULTS"
[[ -n "$PAGER" ]] && alias pager="${PAGER}"
alias colorscheme='~/repo/dotfiles/scripts/colorscheme.sh'
alias tmuxinit='~/repo/dotfiles/scripts/tmuxinit.sh'

if (( $+commands[lsd] )); then
    alias ls='lsd'
    alias tree='lsd --tree'
fi

if [[ "$OSTYPE" == linux* ]]; then
    alias open="xdg-open"
fi
# }}}
# {{{Functions
cdh() { # {{{
    local idx
    idx=$(dirs -v | fzf | awk '{print $1}')
    [[ -n "$idx" ]] && pushd +"$idx" > /dev/null
} # }}}
cdr() { # {{{
    local root
    root=$(git rev-parse --show-toplevel 2> /dev/null) && cd "$root"
} # }}}
cdf() { # {{{
    local dir
    dir=$(find "${1:-.}" -path '*/.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$dir"
} # }}}
cdfa() { # {{{
    local dir
    dir=$(find "${1:-.}" -not -path '*/.git*' -type d 2> /dev/null | fzf) && cd "$dir"
} # }}}
rustupdate() { # {{{
    if (( $+commands[rustup] )); then
        echo "==> Updating rust..."
        rustup update
    fi
    if (( $+commands[cargo-install-update] )); then
        echo "==> Updating packages using cargo install-update..."
        cargo install-update -ag
    elif (( $+commands[cargo] )); then
        echo "==> Updating packages using cargo install..."
        local pkgs
        pkgs=(${=$(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')})
        (( ${#pkgs} )) && cargo install $pkgs
    fi
    if (( $+commands[cargo-cache] )); then
        echo "==> Cleaning cache..."
        cargo cache -a
    fi
} # }}}
pacclean() { # {{{
    emulate -L zsh
    setopt extended_glob null_glob

    sudo paccache -rf -k 0
    local orphans
    orphans=(${=$(pacman -Qdtq)})
    (( ${#orphans} )) && sudo pacman -Rns $orphans

    local dirs
    dirs=("$HOME/.cache/pikaur/build/"*~*.git(/))
    (( ${#dirs} )) && sudo rm -rf $dirs

    dirs=("$HOME/.local/share/pikaur/aur_repos/"*~*.git(/))
    (( ${#dirs} )) && sudo rm -rf $dirs

    rm -rf "$HOME/.cache/pikaur/pkg"
    sync
} # }}}
_auto_activate_venv() { # {{{
    local venv_dir
    if [[ -f "./.venv/bin/activate" ]]; then
        venv_dir="$PWD/.venv"
    elif [[ -f "./venv/bin/activate" ]]; then
        venv_dir="$PWD/venv"
    else
        return
    fi

    # Deactivate any existing virtual environment if it differs from the current one
    if [[ -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV" != "$venv_dir" ]]; then
        deactivate
    fi

    # Activate the target virtual environment if not already active
    if [[ "$VIRTUAL_ENV" != "$venv_dir" ]]; then
        source "${venv_dir}/bin/activate"
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _auto_activate_venv
# }}}
# }}}
# {{{Completion
zcomp_init() {
    local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
    [[ -d "${zcompdump:h}" ]] || mkdir -p "${zcompdump:h}"

    autoload -Uz compinit bashcompinit
    # Regenerate zcompdump once every 24 hours; otherwise skip security check (-C)
    if [[ -n "$zcompdump"(#qN.mh+24) || ! -f "$zcompdump" ]]; then
        compinit -d "$zcompdump"
    else
        compinit -C -d "$zcompdump"
    fi
    bashcompinit

    # Compile zcompdump to bytecode (.zwc) in background if outdated
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump" &!
    fi

    # Completion options
    setopt menu_complete         # Insert the first match immediately on single Tab
    setopt auto_menu             # Show completion menu on successive Tab press
    setopt auto_list             # Automatically list choices on ambiguous completion
    setopt auto_param_slash      # Add trailing slash when completing a directory
    setopt complete_in_word      # Complete from both ends of a word
    setopt always_to_end         # Move cursor to the end of a completed word
    setopt path_dirs             # Perform path search even on command names with slashes
    unsetopt flow_control        # Disable start/stop characters (Ctrl-S / Ctrl-Q) in editor

    # Cache expensive completions (e.g., apt, pacman, cargo, docker)
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

    # Case-insensitive, partial-word, and substring matching
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    # Menu, grouping, and descriptions
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*:matches' group 'yes'
    zstyle ':completion:*:options' description 'yes'
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
    zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
    zstyle ':completion:*:messages' format ' %F{purple}-- %d --%f'
    zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
    zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' verbose yes

    # Fuzzy matching for mistyped completions
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*:match:*' original only
    zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

    # Ignore internal/unavailable functions
    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

    # Array subscript sorting
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # Directory & file colors
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")'

    # Directory navigation completion
    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
    zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
    zstyle ':completion:*' squeeze-slashes true

    # History word completion
    zstyle ':completion:*:history-words' stop yes
    zstyle ':completion:*:history-words' remove-all-dups yes
    zstyle ':completion:*:history-words' list false
    zstyle ':completion:*:history-words' menu yes

    # Environment variables
    zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

    # Hostname completion from known_hosts, /etc/hosts, and ~/.ssh/config
    zstyle -e ':completion:*:hosts' hosts 'reply=(
        ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
        ${=${(f)"$(cat /etc/hosts(N) 2> /dev/null)"}%%\#*}
        ${=${${${${(@M)${(f)"$(cat ~/.ssh/config(N) 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
    )'

    # Ignore system service accounts
    zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
    zstyle '*' single-ignored show

    # Prevent duplicate file suggestions in rm/kill/diff and auto-rehash new binaries
    zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
    zstyle ':completion:*:rm:*' file-patterns '*:all-files'
    zstyle ':completion:*' rehash true

    # Process completion for kill
    zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
    zstyle ':completion:*:*:kill:*' menu yes select
    zstyle ':completion:*:*:kill:*' force-list always
    zstyle ':completion:*:*:kill:*' insert-ids single

    # Man pages
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # SSH / SCP / RSYNC
    zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
    zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
    zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host hosts-ipaddr
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
}
# }}}
# {{{Plugins
# Bootstrap Zinit
if [[ ! -f "$HOME/.zinit/bin/zinit.zsh" ]]; then
    mkdir -p "$HOME/.zinit"
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin"
fi
source "$HOME/.zinit/bin/zinit.zsh"
# {{{powerlevel10k
PURE_POWER_MODE=modern
zinit ice depth=1 atload'[[ -f "$HOME/.zsh-theme" ]] && source "$HOME/.zsh-theme"'
zinit light romkatv/powerlevel10k
# }}}
# {{{neofetch
zinit ice pick"neofetch" as"program"
zinit snippet "https://testingcf.jsdelivr.net/gh/dylanaraps/neofetch@master/neofetch"
# }}}
# {{{sysz
zinit ice pick"sysz" as"program"
zinit snippet "https://testingcf.jsdelivr.net/gh/joehillen/sysz@master/sysz"
# }}}
# {{{pastebin
export PB_DOMAIN="share.sainnhe.dev"
zinit ice pick"pb" as"program"
zinit snippet "https://testingcf.jsdelivr.net/gh/SharzyL/pastebin-worker@goshujin/scripts/pb"
# }}}
# {{{completions
zinit ice wait'0a' lucid pick"_pb" as"completion"
zinit snippet "https://testingcf.jsdelivr.net/gh/SharzyL/pastebin-worker@goshujin/scripts/_pb"

zinit ice wait'0a' lucid depth=1 \
    atload"zcomp_init; zicdreplay" \
    atpull"zinit cclear && zinit creinstall -q sainnhe/zsh-completions"
zinit light sainnhe/zsh-completions
# }}}
# {{{zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
zinit ice wait'0b' lucid depth=1 atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
bindkey '^[z' autosuggest-execute
bindkey '^[x' autosuggest-execute
# }}}
# {{{zsh-history-substring-search
zinit ice wait'0b' lucid depth=1
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# }}}
# {{{fzf-widgets
zinit ice wait'0b' lucid depth=1
zinit light ytet5uy4/fzf-widgets
bindkey '^F' fzf-select-widget
bindkey '^R' fzf-insert-history
bindkey -r "^[c"
bindkey -r "^T"
# }}}
# {{{fzf-marks
FZF_MARKS_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-marks"
FZF_MARKS_COMMAND="fzf"
FZF_MARKS_COLOR_RHS="249"
FZF_MARKS_JUMP="^z"
zinit ice wait'0b' lucid depth=1
zinit light urbainvaes/fzf-marks
# }}}
# {{{zsh-autopair
zinit ice wait'0b' lucid depth=1
zinit light hlissner/zsh-autopair
# }}}
# {{{dotenv
zinit ice wait'0b' lucid
zinit snippet "https://testingcf.jsdelivr.net/gh/ohmyzsh/ohmyzsh@master/plugins/dotenv/dotenv.plugin.zsh"
# }}}
# {{{fast-syntax-highlighting
zinit ice wait'0c' lucid depth=1 atload'FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"'
zinit light zdharma-continuum/fast-syntax-highlighting
# }}}
# }}}
# zprof # Uncomment and execute: time zsh -i -c exit
# vim: set fdm=marker fmr={{{,}}}:
