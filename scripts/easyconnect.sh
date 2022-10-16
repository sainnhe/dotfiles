#!/usr/bin/env sh

# Usage:
# mkdir -p ~/.config/easyconnect
# ./easyconnect.sh <podman-or-docker> <vpn-domain>
# socks5:   1080
# http:     8888

"${1}" run \
    --device /dev/net/tun \
    --cap-add NET_ADMIN \
    -p 127.0.0.1:1081:1080 \
    -p 127.0.0.1:1082:8888 \
    -e EC_VER=7.6.3 \
    -e CLI_OPTS="-d ${2}" \
    -it \
    --rm \
    --name=easyconnect \
    hagb/docker-easyconnect:cli
