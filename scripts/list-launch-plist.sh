#!/usr/bin/env bash

sudo -- bash -c 'echo " - $(date) -"; while IFS= read -r eachPlist; do echo "-$eachPlist"; /usr/bin/defaults read "$eachPlist"; done <<< "$(/usr/bin/find /Library/LaunchDaemons /Library/LaunchAgents ~/Library/LaunchAgents /private/var/root/Library/LaunchAgents /private/var/root/Library/LaunchDaemons -name "*.plist")"; /usr/bin/defaults read com.apple.loginWindow LogoutHook; /usr/bin/defaults read com.apple.loginWindow LoginHook' > ~/Desktop/launch.txt
