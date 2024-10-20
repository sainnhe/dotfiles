#!/usr/bin/env bash

echo 'Execute "sudo usermod -aG disk $USER" to enable the user to access the disk, then logout and login again.'
printf "Continue? [N/y] "
read -r ans
if [[ $ans != "y" ]]; then
    exit 1
fi
pikaur -S --asdeps \
        ttf-ms-win11-auto \
        ttf-ms-win11-auto-zh_cn
