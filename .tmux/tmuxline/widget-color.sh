#!/usr/bin/env bash

_os="$(uname -s)"

if [[ "${_os}" == "Darwin" ]]; then
    echo "#[fg=blue]"
else
    echo "#[fg=green]"
fi
