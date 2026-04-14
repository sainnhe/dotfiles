autoload -Uz add-zsh-hook

_update_gpg_tty() {
    export GPG_TTY=$(tty)
    gpg-connect-agent "SETENV TERM=$TERM" updatestartuptty /bye >/dev/null 2>&1
}

add-zsh-hook preexec _update_gpg_tty
