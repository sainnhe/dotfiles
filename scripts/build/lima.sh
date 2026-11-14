#!/bin/bash
set -euo pipefail

make clean
make PREFIX="$HOME/.local" -j"$(nproc)"
make PREFIX="$HOME/.local" install
