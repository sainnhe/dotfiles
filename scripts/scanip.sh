#!/usr/bin/env bash

my_ip="$(ifconfig | grep 192.168 | sed -e 's/^.*inet //' -e 's/ netmask.*//')"
printf "My IP Address: %s\n\n" "${my_ip}"
nmap -sn "${my_ip}/24"
