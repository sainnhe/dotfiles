#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/node_modules/.bin:$HOME/.local/bin:$HOME/.local/share/bin:$PATH"
