#!/bin/env bash

STAT=$(ps -elf | grep "polybar.*mainbar" | grep -v "grep")

if [ "$STAT"x == ""x ]; then
    i3 gaps bottom all set 35
    polybar --reload mainbar
else
    i3 gaps bottom all set 0
    pkill polybar
    ps -elf | grep "polybar.*check-network" | grep -v grep | grep -o '^[^[:blank:]]*[[:blank:]]*[^[:blank:]]*[[:blank:]]*[^[:blank:]]*[[:blank:]]*[^[:blank:]]*' | grep -o '[[:digit:]]*$' | xargs -i{} kill -9 {}
fi
