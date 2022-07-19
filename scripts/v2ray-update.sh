#!/usr/bin/env bash

# Update /etc/v2ray/config.json based on subscription url.

# Usage:
# sudo ./v2ray-update.sh <subscription-url>

[ -x "$(command -v v2ray-tools)" ] || (echo "==> 'v2ray-tools' not installed." && echo "==> Install it by 'npm install -g v2ray-tools'" && exit 1)
[ -x "$(command -v v2ray)" ] || (echo "==> 'v2ray' not installed." && exit 2)

curl -sL "${1}" | base64 --decode | while read line ; do
   if [[ "$(v2ray-tools vmesstest --url $line)" == "ok"* ]]; then
      v2ray-tools vmess2config --port 1080 --url "$line" > /etc/v2ray/config.json
      systemctl restart v2ray.service
      exit 0
   fi
done
