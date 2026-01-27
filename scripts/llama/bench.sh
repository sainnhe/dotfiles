#!/usr/bin/env bash

llama-bench \
    --progress \
    -m "$1" \
    -ngl 99 \
    -p 2048 \
    -n 128 \
    -fa 1 \
    -ctk q8_0 \
    -ctv q8_0 \
    -b 2048 \
    -ub 512 \
    -t 6 \
    -r 5
