# {{{Install
# sudo pacman -S powerline
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# npm install --user pure-promp
# }}}
# {{{Functions
test_cmd_pre () {
    command -v "$1" >/dev/null
}
test_cmd () {
    test_cmd_pre "$1" && echo 'yes' || echo 'no'
}
# }}}
# {{{Variables
export TERM=xterm-256color
export PATH="$HOME/.local/bin:$HOME/.local/share/bin:$PATH"
export TERM_Emulator=$(ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))")
# }}}
# {{{Settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
autoload -U promptinit; promptinit  # prompt
autoload -Uz compinit  # completion
export PURE_PROMPT_SYMBOL="➢"
export PURE_PROMPT_VICMD_SYMBOL="➣"
compinit  # completion
zstyle ':completion:*' menu select  # use arrow key for completion
setopt COMPLETE_ALIASES  # complete alias
setopt HIST_IGNORE_DUPS  # eliminate duplicate entries in history
zstyle ':completion::complete:*' gain-privileges 1  # enabling autocompletion of privileged environments in privileged commands
# {{{alias
alias ls='ls --color=auto'
alias CT='bash /home/sainnhe/Scripts/ChangeThemes/CT.sh'
alias KCT='kcmcolorfulhelper -s -p'
alias git-proxy='bash /home/sainnhe/Scripts/git-proxy.sh'
alias bebusy='/home/sainnhe/Scripts/bebusy.py'
alias youtube-mpv='bash ~/Scripts/youtube-mpv.sh'
alias download-youtube-subtitles='bash ~/Scripts/download-youtube-subtitles.sh'
alias CLEAN='bash ~/Scripts/CLEAN.sh'
alias switch-v2ray='sudo bash ~/Scripts/v2ray/v2ray_switch.sh'
alias gsconnect='bash ~/Scripts/gsconnect.sh'
alias roll='bash ~/Scripts/roll.sh'
alias zip-r='bash ~/Scripts/zip.sh'
alias tmux-help='bash ~/Scripts/tmux-help.sh'
# }}}
# {{{manpager
if [[ "$nvim_exist" == "yes" ]]; then
    export MANPAGER="nvim --cmd 'let g:VIM_MANPAGER = 1' -c MANPAGER -"
elif [[ "$nvim_exist" == "no" ]]; then
    export MANPAGER="vim --cmd 'let g:VIM_MANPAGER = 1' -c MANPAGER -"
fi
# }}}
# }}}
# {{{Plugins
# https://github.com/zplug/zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug load
fast-theme q-jmnemonic > /dev/null
# {{{zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
bindkey '^l' autosuggest-accept
# }}}
# {{{zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}}
# }}}
# {{{TMUX
# {{{TMUX Start
tmux_start () {
alias tmux='tmux -2'
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
nvim_exist=$(test_cmd nvim)
if [[ "$TERM_Emulator" != "tilda" ]]; then
    if [[ -z "$TMUX" ]] ;then
        ID="`tmux ls | grep -vm1 attached | grep Alpha | cut -d: -f1`" # check if Alpha session exist
        if [[ -z "$ID" ]] ;then # if not, creat a new one
            tmux new-session -d -s Alpha -n VIM
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
    if [[ -z "$TMUX" ]] ;then
        ID="`tmux ls | grep -vm1 attached | grep Beta | cut -d: -f1`" # check if Beta session exist
        if [[ -z "$ID" ]] ;then # if not, creat a new one
            tmux new-session -d -s Beta -n VIM
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
# }}}
# {{{TMUX Init
alias tmux='tmux -2'
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
nvim_exist=$(test_cmd nvim)
if [[ "$TERM_Emulator" == "tilda" ]]; then
    if [[ -z "$TMUX" ]] ;then
        ID="`tmux ls | grep -vm1 attached | grep Beta | cut -d: -f1`" # check if Beta session exist
        if [[ -z "$ID" ]] ;then # if not, creat a new one
            tmux new-session -d -s Beta -n VIM
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
# }}}
# }}}
