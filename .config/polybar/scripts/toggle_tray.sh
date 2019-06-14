#!/bin/bash

GREP_RESULT=$(grep -e "^; tray" ~/.config/polybar/config)

if [ "$GREP_RESULT"x == ""x ]; then
    sed -i -e "s/tray/; tray/" ~/.config/polybar/config
else
    sed -i -e "s/; tray/tray/" ~/.config/polybar/config
fi
