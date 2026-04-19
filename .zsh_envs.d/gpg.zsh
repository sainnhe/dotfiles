# SSH
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Hook
_update_gpg_connect_agent() {
  gpg-connect-agent "SETENV TERM=$TERM" updatestartuptty /bye >/dev/null 2>&1
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _update_gpg_connect_agent
