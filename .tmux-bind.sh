#!/bin/bash

# session
tmux bind-key -T prefix e choose-tree -Zs

# reload config file
tmux bind-key -T prefix r source-file ~/.tmux.conf

# window
tmux bind-key -n C-t new-window
tmux bind-key -n C-w unlink-window -k
tmux bind-key -n C-left prev
tmux bind-key -n C-right next
tmux bind-key -n C-up swap-window -t -1
tmux bind-key -n C-down swap-window -t +1

# copy mode
tmux bind-key -T prefix Space copy-mode
tmux bind-key -T copy-mode-vi 'v' send -X begin-selection

# plugins
tmux bind-key -T prefix C-p run-shell "tmux-pomodoro start"
tmux bind-key -T prefix M-p run-shell "tmux-pomodoro clear"

if [[ "$1" == "yes" ]]; then
    # tmux bind-key -n C-Space run-shell -b "$HOME/.tmux-bind.sh no"
    tmux bind-key -T prefix C-Space run-shell -b "$HOME/.tmux-bind.sh no"
    # pane
    tmux unbind-key -T prefix C-s
    tmux unbind-key -T prefix C-v
    tmux unbind-key -T prefix C-h
    tmux unbind-key -T prefix C-j
    tmux unbind-key -T prefix C-k
    tmux unbind-key -T prefix C-l
    tmux unbind-key -T prefix C-x
    tmux bind-key -n C-s split-window
    tmux bind-key -n C-v split-window -h
    tmux bind-key -n C-h select-pane -L
    tmux bind-key -n C-j select-pane -D
    tmux bind-key -n C-k select-pane -U
    tmux bind-key -n C-l select-pane -R
    tmux bind-key -n C-x kill-pane
    touch /tmp/.tmux-bind.lck
elif [[ "$1" == "no" ]]; then
    # tmux bind-key -n C-Space run-shell -b "$HOME/.tmux-bind.sh yes"
    tmux bind-key -T prefix C-Space run-shell -b "$HOME/.tmux-bind.sh yes"
    # pane
    tmux unbind-key -n C-s
    tmux unbind-key -n C-v
    tmux unbind-key -n C-h
    tmux unbind-key -n C-j
    tmux unbind-key -n C-k
    tmux unbind-key -n C-l
    tmux unbind-key -n C-x
    tmux bind-key -T prefix C-s split-window
    tmux bind-key -T prefix C-v split-window -h
    tmux bind-key -T prefix C-h select-pane -L
    tmux bind-key -T prefix C-j select-pane -D
    tmux bind-key -T prefix C-k select-pane -U
    tmux bind-key -T prefix C-l select-pane -R
    tmux bind-key -T prefix C-, resize-pane -L
    tmux bind-key -T prefix C-- resize-pane -D
    tmux bind-key -T prefix C-= resize-pane -U
    tmux bind-key -T prefix C-. resize-pane -R
    tmux bind-key -T prefix C-x kill-pane
    if [ -e "/tmp/.tmux-bind.lck" ]; then
        rm /tmp/.tmux-bind.lck
    fi
fi
