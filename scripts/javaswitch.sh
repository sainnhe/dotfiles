#!/usr/bin/env bash

printf "=> Current version information:\n\n"
java -version
printf "\n=> Select expected java version:\n"

java_lib="$(ls /Library/Java/JavaVirtualMachines | grep -v default | fzf)"
if [ -z "$java_lib" ]; then
    printf "\n=> Not selected."
    exit 1
else
    sudo ln -sfn /Library/Java/JavaVirtualMachines/$java_lib /Library/Java/JavaVirtualMachines/default
    printf "=> Successfully changed to $java_lib.\n=> Current version information:\n\n"
    java -version
fi
