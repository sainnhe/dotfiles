#!/usr/bin/env sh

curl -sL "https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance" |\
    grep -Po '\"Version\":\"20.*?\"' |\
    sed -r -e 's/^.*\":\"//' \
    -e 's/\"$//'

# curl -sL "https://github.com/microsoft/pylance-release/raw/master/CHANGELOG.md" |\
#     grep '##' |\
#     head -n 1 |\
#     sed -r -e 's/^## //' \
#     -e 's/ \(.*\)//'
