# {{{Variables
export TERM="xterm-256color"
export PATH="$HOME/.local/bin:$HOME/.local/share/bin:$PATH"
export TERM_Emulator=$(ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))")
# }}}
# {{{functions
test_cmd_pre () {
    command -v "$1" >/dev/null
}
test_cmd () {
    test_cmd_pre "$1" && echo 'yes' || echo 'no'
}
# }}}
# {{{Install
# yay -S zsh-theme-powerlevel9k powerline
# sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# https://archive.archlinux.org/packages/z/zsh-theme-powerlevel9k/zsh-theme-powerlevel9k-0.6.4-1-any.pkg.tar.xz
# }}}
# {{{TMUX Init
nvim_exist=$(test_cmd nvim)
if [[ "$TERM_Emulator" != "tilda" ]]; then
    if [[ -z "$TMUX" ]] ;then
        ID="`tmux ls | grep -vm1 attached | grep Alpha | cut -d: -f1`" # check if Alpha session exist
        if [[ -z "$ID" ]] ;then # if not, creat a new one
            tmux new-session -d -s Alpha -n VIM
            tmux new-window -t Alpha -n Shell
            tmux send-keys -t Alpha:VIM "cd ~" Enter
            if [[ "$nvim_exist" == "yes" ]]; then
                tmux send-keys -t Alpha:VIM "nvim" Enter
            elif [[ "$nvim_exist" == "no" ]]; then
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
./.tmux_bind.sh yes
# }}}
set -o ignoreeof
set -o noclobber

alias ls='ls --color=auto'
alias CT='bash /home/sainnhe/Scripts/ChangeThemes/CT.sh'
alias git-proxy='bash /home/sainnhe/Scripts/git-proxy.sh'
alias mkpkg-less='less /etc/makepkg.conf'
alias mkpkg-direct='sudo cp /etc/makepkg.conf.direct.bak /etc/makepkg.conf'
alias mkpkg-proxy='sudo cp /etc/makepkg.conf.proxy.bak /etc/makepkg.conf'
alias bebusy='/home/sainnhe/Scripts/bebusy.py'
alias youtube-mpv='bash ~/Scripts/youtube-mpv.sh'
alias download-youtube-subtitles='bash ~/Scripts/download-youtube-subtitles.sh'
alias CLEAN='bash ~/Scripts/CLEAN.sh'
alias switch-v2ray='sudo bash ~/Scripts/v2ray/v2ray_switch.sh'
alias gsconnect='bash ~/Scripts/gsconnect.sh'
alias roll='bash ~/Scripts/roll.sh'
alias zip-r='bash ~/Scripts/zip.sh'
alias check-sync='rclone check /mnt/ExternalDisk/OneDrive/ remote:/ --checksum'
#alias pacman-less='less /etc/pacman.conf'
#alias pacman-direct='sudo cp /etc/pacman.conf.direct.bak /etc/pacman.conf'
#alias pacman-proxy='sudo cp /etc/pacman.conf.proxy.bak /etc/pacman.conf'


# ZSH_THEME="norm"
# ZSH_THEME="wezm"
# ZSH_THEME="arrow"
# ZSH_THEME="sporty_256"
# {{{powerlevel9k
# Powerline Themes
#注意安装zsh-theme-powerlevel9k这个包
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
# powerlevel9k config
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true #左侧新的一行
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true #右侧新的一行
#终端输入get_icon_names即可看到可设置的图标列表
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="" #图标
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" " #图标
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true #回显加入新的一行
POWERLEVEL9K_DIR_HOME_BACKGROUND="153"
POWERLEVEL9K_DIR_HOME_FOREGROUND="216"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="153"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="195"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="153"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='153'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="195"
POWERLEVEL9K_STATUS_OK_BACKGROUND='193' #151 153 193 195
POWERLEVEL9K_STATUS_OK_FOREGROUND='153'
POWERLEVEL9K_STATUS_CROSS_FOREGROUND='197'
POWERLEVEL9K_STATUS_SHOW_PIPESTATUS_FOREGROUND='246'
POWERLEVEL9K_STATUS_HIDE_SIGNAME_FOREGROUND='246'
POWERLEVEL9K_OK_ICON="\uf303"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable_joined newline status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
#POWERLEVEL9K_HOME_ICON=''
#POWERLEVEL9K_HOME_SUB_ICON=''
#POWERLEVEL9K_FOLDER_ICON=''
#POWERLEVEL9K_ETC_ICON=''
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
# 两个单冒号之间可以是一个三位数的数字，用来代表颜色，具体选择请终端执行以上代码
# 某些变量具有状态属性，设置颜色的时候按照这个格式POWERLEVEL9K_<name-of-segment>_<state>_[BACKGROUND|FOREGROUND]
# Segment       States
# battery       LOW, CHARGING, CHARGED, DISCONNECTED
# context       DEFAULT, ROOT, SUDO, REMOTE, REMOTE_SUDO
# dir   HOME, HOME_SUBFOLDER, DEFAULT, ETC
# dir_writable  FORBIDDEN
# host  LOCAL, REMOTE
# load  CRITICAL, WARNING, NORMAL
# rspec_stats   STATS_GOOD, STATS_AVG, STATS_BAD
# status        ERROR, OK (note: only, if verbose is not false)
# symfony2_tests        TESTS_GOOD, TESTS_AVG, TESTS_BAD
# user  DEFAULT, SUDO, ROOT
# vcs   CLEAN, UNTRACKED, MODIFIED
# vi_mode       NORMAL, INSERT
# 另外大部分变量都可以设置在visual模式下的颜色，格式像这样POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red" 在state和ground之间加上_VISUAL_IDENTIFIER
# }}}



# Plugins
plugins=(web-search completion)

# powerline
powerline-daemon -q
. /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh


# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sainnhe/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# 启动使用方向键控制的自动补全
zstyle ':completion:*' menu select
# 启动命令行别名的自动补全
setopt completealiases
# Alt+Left撤销最后一次cd；Alt+Up返回目录的上一层
cdUndoKey() {
    popd      > /dev/null
    zle       reset-prompt
    echo
    ls
    echo
}
cdParentKey() {
    pushd .. > /dev/null
    zle      reset-prompt
    echo
    ls
    echo
}
zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey





# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/sainnhe/.oh-my-zsh"

# Disable Autoupgrade
DISABLE_AUTO_UPDATE=true

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
