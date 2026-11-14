autoload -Uz add-zsh-hook

_update_gpg_tty() {
  if [ -t 0 ]; then
    export GPG_TTY=$(tty)
  fi
}
add-zsh-hook precmd _update_gpg_tty
