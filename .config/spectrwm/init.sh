#!/usr/bin/env sh

xrandr --dpi 200 &
picom --experimental-backends -b &
polybar --reload mainbar &
fcitx &
redshiftgui &
qv2ray &
feh --bg-fill ~/Pictures/wallpapers/landscape-17.jpg &
