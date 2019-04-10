# {{{Init
# {{{Install
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# npm install --global pure-prompt
# }}}
zmodload zsh/zprof  # zprof | vimpager
export PATH="$HOME/.local/bin:$HOME/.local/share/bin:$PATH"
export TERM=xterm-256color
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
if [[ $(ps -o comm= -p $(($(ps -o ppid= -p $(($(ps -o sid= -p $$))))))) != *"tmux"* ]]; then
    export TERM_Emulator=$(ps -o comm= -p $(($(ps -o ppid= -p $(($(ps -o sid= -p $$)))))))
fi
export EDITOR=nvim
export PAGER="nvim --cmd 'let g:VIM_MANPAGER = 1' -c MANPAGER -"
export MANPAGER="nvim --cmd 'let g:VIM_MANPAGER = 1' -c MANPAGER -"
# }}}
# {{{Functions
test_cmd_pre() { # {{{
    command -v "$1" >/dev/null
} # }}}
test_cmd() { # {{{
    test_cmd_pre "$1" && echo 'yes' || echo 'no'
} # }}}
switch_tmuxline() { # {{{
    echo ""
    echo "archery iceberg darcula_* deus_* github_* hydrangea_* inkstained_* material_* molokai_* vice_* disable"
    echo ""
    read -r TMUXLINE_COLOR_SCHEME
    while [ "$TMUXLINE_COLOR_SCHEME"x != "q"x ]; do
        if [[ "$TMUXLINE_COLOR_SCHEME" == "disable" ]]; then
            echo ""
            echo 'export TMUXLINE_COLOR_SCHEME="disable"'
        else
            tmux source-file "$HOME/.tmux/tmuxline/$TMUXLINE_COLOR_SCHEME.tmux.conf"
        fi
        echo ""
        echo "archery iceberg darcula_* deus_* github_* hydrangea_* inkstained_* material_* molokai_* vice_* disable"
        echo ""
        read -r TMUXLINE_COLOR_SCHEME
    done
} # }}}
# {{{fzy
# fuzzy match dirs and cd
cdf() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzy --lines=15 --prompt='➤ ') &&
  cd "$dir"
}
# include hidden dirs
cdfa() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzy --lines=15 --prompt='➤ ') && cd "$dir"
}
# }}}
# }}}
# {{{Settings
# {{{general
set -o monitor
set +o nonotify
umask 077
setopt HIST_IGNORE_DUPS                         # eliminate duplicate entries in history
setopt correctall                               # enable auto correction
setopt autopushd pushdignoredups                # auto push dir into stack and and don’t duplicate them
# }}}
# {{{prompt
autoload -U promptinit
promptinit
# }}}
# {{{completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*' menu select                                      # use arrow key for completion
zstyle ':completion::complete:*' gain-privileges 1                      # enabling autocompletion of privileged environments in privileged commands
zstyle ':completion:*' rehash true                                      # auto rehash new command
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'                 # beautify completion style
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'  # beautify completion style
zstyle ':completion:*' completer _complete _match _approximate          # fuzzy match completions
zstyle ':completion:*:match:*' original only                            # fuzzy match completions
zstyle ':completion:*:approximate:*' max-errors 1 numeric               # fuzzy match completions
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';      #highlight prefix
setopt menu_complete                                                    # press <Tab> once to select item
setopt COMPLETE_ALIASES                                                 # complete alias
# }}}
# }}}
# {{{Alias
alias ls='lsd'
alias ls-rec='lsd --tree'
alias ls-all='/usr/bin/ls --color=auto -F -ilsh'
alias fzy="fzy --lines=15 --prompt='➤ '"
alias cdl='dirs -vl | fzy'
alias cdC='dirs -c'
alias cdh='pushd +$( dirs -v | fzy | grep -o "[[:digit:]]") > /dev/null'
alias cdc='popd +$( dirs -v | fzy | grep -o "[[:digit:]]") > /dev/null'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias du='du -hc'
alias df='df -h'
alias cp='cp -ip'
alias mv='mv -i'
alias jobl='jobs -l'
alias jobj='fg %-'
alias jobf="fg %\$(jobs | grep '[[[:digit:]]*]' | fzy --lines=15 --prompt='➤ ' | grep -o '[[[:digit:]]*]' | grep -o '[[:digit:]]*')"
alias jobb="bg %\$(jobs | grep '[[[:digit:]]*]' | fzy --lines=15 --prompt='➤ ' | grep -o '[[[:digit:]]*]' | grep -o '[[:digit:]]*')"
alias jobk="kill %\$(jobs | grep '[[[:digit:]]*]' | fzy --lines=15 --prompt='➤ ' | grep -o '[[[:digit:]]*]' | grep -o '[[:digit:]]*')"
alias nnn='PAGER= nnn'
alias vimpager="nvim --cmd 'let g:VIM_MANPAGER = 1' -c MANPAGER -"
alias help="bash ~/Scripts/help.sh"
alias GCT='bash /home/sainnhe/Scripts/ChangeThemes/GCT.sh'
alias KCT='kcmcolorfulhelper -s -p'
alias tmux='tmux -2'
alias git-proxy='bash /home/sainnhe/Scripts/git-proxy.sh'
alias bebusy='/home/sainnhe/Scripts/bebusy.py'
alias youtube-mpv='bash ~/Scripts/youtube-mpv.sh'
alias download-youtube-subtitles='bash ~/Scripts/download-youtube-subtitles.sh'
alias CLEAN='bash ~/Scripts/CLEAN.sh'
alias switch_v2ray='bash ~/Scripts/v2ray/v2ray_switch.sh'
alias gsconnect='bash ~/Scripts/gsconnect.sh'
alias termcolorlist='bash ~/Scripts/termcolor.sh'
alias roll='bash ~/Scripts/roll.sh'
alias zip-r='bash ~/Scripts/zip.sh'
alias dtop='gotop -b -c vice'
alias ltop='gotop -b -c monokai'
alias browsh-docker='docker run --rm -it browsh/browsh'
alias net-test="bash ~/Scripts/net-test.sh"
alias t='goldendict'
if [[ "$TERM_Emulator" == "tilda" ]]; then
    alias g='BROWSER=w3m proxychains -q googler -x -n 3 -N -c us -l en --color nJmkxy'
    alias d='BROWSER=w3m proxychains -q ddgr -n 3 -x --unsafe --color mJklxy'
else
    alias g='BROWSER=w3m proxychains -q googler -x -n 7 -N -c us -l en --color nJmkxy'
    alias d='BROWSER=w3m proxychains -q ddgr -n 7 -x --unsafe --color mJklxy'
fi
# }}}
# {{{Plugins
# https://github.com/zplug/zplug
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme
zplug 'zdharma/fast-syntax-highlighting'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'skywind3000/z.lua'
zplug 'plugins/vi-mode', from:oh-my-zsh
zplug 'plugins/command-not-found', from:oh-my-zsh
zplug 'plugins/pass', from:oh-my-zsh
zplug 'plugins/colored-man-pages', from:oh-my-zsh
zplug 'plugins/web-search', from:oh-my-zsh
zplug 'plugins/extract', from:oh-my-zsh
zplug 'plugins/frontend-search', from:oh-my-zsh
zplug 'RobSis/zsh-completion-generator'
zplug 'ytet5uy4/fzf-widgets'
zplug load
# {{{theme
export TMUXLINE_COLOR_SCHEME="github_insert"
fast-theme q-jmnemonic >/dev/null
export PURE_PROMPT_SYMBOL="➤"
export PURE_PROMPT_VICMD_SYMBOL="⮞"
# export PURE_PROMPT_SYMBOL="➢"
# export PURE_PROMPT_VICMD_SYMBOL="➣"
# export PURE_PROMPT_SYMBOL="❯"
# export PURE_PROMPT_VICMD_SYMBOL="❮"
# }}}
# {{{fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="
-m --height=50%
--layout=reverse
--prompt='➤ '
--ansi
--tabstop=4
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
"
source /usr/share/fzf/completion.zsh  # 模糊匹配路径，**<Tab>触发
bindkey '^Fl'  fzf-select-widget
bindkey '^Fh'  fzf-insert-history
bindkey '^Ff' fzf-insert-files
bindkey '^Fd' fzf-insert-directory
# }}}
# {{{zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
bindkey '^[^M' autosuggest-execute
# }}}
# {{{zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}}
# {{{z.lua
export _ZL_DATA="$HOME/.cache/.zlua"
export _ZL_MATCH_MODE=1
alias zc='z -c' # 严格匹配当前路径的子路径
alias zz='z -i' # 使用交互式选择模式
alias zf='z -I' # 使用 fzf 对多个结果进行选择
# }}}
# {{{zsh-completion-generator
# gencomp fzf
# gencomp fzy
# gencomp firefox-developer-edition
# gencomp gotop
# gencomp browsh
# }}}
# }}}
# {{{TMUX
# {{{TMUX Start
tmux_start() {
    alias tmux='tmux -2'
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    nvim_exist=$(test_cmd nvim)
    if [[ "$TERM_Emulator" != "tilda" ]]; then
        if [[ -z "$TMUX" ]]; then
            ID="$(tmux ls | grep -vm1 attached | grep Alpha | cut -d: -f1)" # check if Alpha session exist
            if [[ -z "$ID" ]]; then # if not, creat a new one
                tmux new-session -d -s Alpha -n VIM
                tmux source-file "$HOME/.tmux/tmuxline/$TMUXLINE_COLOR_SCHEME.tmux.conf"
                tmux new-window -t Alpha -n Shell
                tmux send-keys -t Alpha:VIM "cd ~" Enter
                if [[ "$nvim_exist" == "yes" ]]; then
                    tmux send-keys -t Alpha:VIM "export TERM_Emulator=$TERM_Emulator" Enter
                    tmux send-keys -t Alpha:VIM "nvim" Enter
                elif [[ "$nvim_exist" == "no" ]]; then
                    tmux send-keys -t Alpha:VIM "export TERM_Emulator=$TERM_Emulator" Enter
                    tmux send-keys -t Alpha:VIM "vim" Enter
                fi
                tmux attach -t Alpha:Shell
            else
                tmux attach-session -t Alpha # if available attach to it # else, attach it
            fi
        fi
    elif [[ "$TERM_Emulator" == "tilda" ]]; then
        if [[ -z "$TMUX" ]]; then
            ID="$(tmux ls | grep -vm1 attached | grep Beta | cut -d: -f1)" # check if Beta session exist
            if [[ -z "$ID" ]]; then # if not, creat a new one
                tmux new-session -d -s Beta -n VIM
                tmux source-file "$HOME/.tmux/tmuxline/$TMUXLINE_COLOR_SCHEME.tmux.conf"
                tmux new-window -t Beta -n Shell
                tmux send-keys -t Beta:VIM "cd ~" Enter
                if [[ "$nvim_exist" == "yes" ]]; then
                    tmux send-keys -t Beta:VIM "nvim" Enter
                elif [[ "$nvim_exist" == "no" ]]; then
                    tmux send-keys -t Beta:VIM "vim" Enter
                fi
                tmux attach -t Beta:Shell
            else
                tmux attach-session -t Beta # if available attach to it # else, attach it
            fi
        fi
    fi
    ~/.tmux_bind.sh no
}
# if [[ "$TERM_Emulator" == "tilda" ]]; then
# fi
# }}}
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
nvim_exist=$(test_cmd nvim)
tmux_start
~/.tmux_bind.sh no
# }}}
