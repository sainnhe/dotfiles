#!/bin/env bash

STAT=$(ps -elf | grep "polybar.*mainbar" | grep -v "grep")

if [ "$STAT"x == ""x ]; then
    polybar --reload mainbar
else
    pkill polybar
    ps -elf | grep "polybar.*check-network" | grep -v grep | grep -o '^[^[:blank:]]*[[:blank:]]*[^[:blank:]]*[[:blank:]]*[^[:blank:]]*[[:blank:]]*[^[:blank:]]*' | grep -o '[[:digit:]]*$' | xargs -i{} kill -9 {}
fi
