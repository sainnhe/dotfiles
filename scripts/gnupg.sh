#!/usr/bin/env bash

# Usage:
# ./gnupg.sh backup <key-id>
# ./gnupg.sh restore <file>

backup() {
    mkdir -p /tmp/gnupg-backup
    gpg --export --export-options backup --output /tmp/gnupg-backup/public.gpg "${1}"
    gpg --export-secret-keys --export-options backup --output /tmp/gnupg-backup/private.gpg "${1}"
    tar cf backup.tar -C /tmp/gnupg-backup .
    rm -r /tmp/gnupg-backup
    printf "\nBackup saved to backup.tar\n"
}

restore() {
    mkdir -p /tmp/gnupg-restore
    tar xf "${1}" -C /tmp/gnupg-restore
    gpg --import /tmp/gnupg-restore/public.gpg
    gpg --import /tmp/gnupg-restore/private.gpg
    rm -r /tmp/gnupg-restore
    printf "\nBackup restored\n"
    printf "To edit trust level: gpg --edit-key <key-id>\n"
    printf "Type \`trust\` and press Enter\n"
    printf "!!! Don't forget to delete primary secret key !!!"
}

if [ "${1}" = 'backup' ]; then
    backup "${2}"
elif [ "${1}" = 'restore' ]; then
    restore "${2}"
fi
