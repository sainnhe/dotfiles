#!/usr/bin/env bash

tmux new-session \
        -c "${HOME}" \
        -s Beta \
        -d

tmux new-session \
        -c "${HOME}" \
        -s Alpha \
        -d
tmux new-window \
        -c "${HOME}" \
        -t Alpha:1 \
        -d

tmux attach-session \
        -t Alpha
