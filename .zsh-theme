export TMUXLINE_COLOR_SCHEME="simplify_visual"
fast-theme q-jmnemonic >/dev/null

# Original location: https://github.com/romkatv/dotfiles-public/blob/master/.purepower.
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"

PURE_POWER_MODE=fancy

if test -z "${ZSH_VERSION}"; then
  echo "purepower: unsupported shell; try zsh instead" >&2
  return 1
  exit 1
fi

() {
  emulate -L zsh && setopt no_unset pipe_fail

  # `$(_pp_cond x y`) evaluates to `x` in portable mode and to `y` in fancy mode.
  if [[ ${PURE_POWER_MODE:-fancy} == fancy ]]; then
    function _pp_cond() { echo -E $2 }
  else
    if [[ $PURE_POWER_MODE != portable ]]; then
      echo -En "purepower: invalid mode: ${(qq)PURE_POWER_MODE}; " >&2
      echo -E  "valid options are 'fancy' and 'portable'; falling back to 'portable'" >&2
    fi
    function _pp_cond() { echo -E $1 }
  fi

  typeset -ga POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      dir_writable dir vcs)

  typeset -ga POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
      status command_execution_time background_jobs custom_rprompt context)

  local ins=$(_pp_cond '>' '➤')
  local cmd=$(_pp_cond ')' '⮞')
  if (( ${PURE_POWER_USE_P10K_EXTENSIONS:-1} )); then
    local p="\${\${\${KEYMAP:-0}:#vicmd}:+${${ins//\\/\\\\}//\}/\\\}}}"
    p+="\${\${\$((!\${#\${KEYMAP:-0}:#vicmd})):#0}:+${${cmd//\\/\\\\}//\}/\\\}}}"
  else
    p=$ins
  fi
  local ok="%F{$(_pp_cond 005 207)}${p}%f"
  local err="%F{$(_pp_cond 001 196)}${p}%f"

  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?.$ok.$err) "
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=$'\n'
  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_WHITESPACE_BETWEEN_{LEFT,RIGHT}_SEGMENTS=

  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_VISUAL_IDENTIFIER_COLOR=$(_pp_cond 013 147)
  typeset -g POWERLEVEL9K_LOCK_ICON=''

  typeset -g POWERLEVEL9K_DIR_{ETC,HOME,HOME_SUBFOLDER,DEFAULT}_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_{ETC,DEFAULT}_FOREGROUND=$(_pp_cond 013 147)
  typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER}_FOREGROUND=$(_pp_cond 004 111)
  typeset -g POWERLEVEL9K_{ETC,FOLDER,HOME,HOME_SUB}_ICON=

  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING}_BACKGROUND=none
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$(_pp_cond 004 111)
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$(_pp_cond 005 147)
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$(_pp_cond 003 216)
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=$(_pp_cond 008 249)
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNTRACKEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNSTAGEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STAGEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_INCOMING_CHANGESFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_OUTGOING_CHANGESFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STASHFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_ACTIONFORMAT_FOREGROUND=001
  typeset -g POWERLEVEL9K_VCS_LOADING_ACTIONFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_LOADING_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_GIT_ICON=' '
  typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=' '
  typeset -g POWERLEVEL9K_VCS_GIT_GITLAB_ICON=' '
  typeset -g POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=' '
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '
  typeset -g POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=' '
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON=' '
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON=''
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON=''
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='✩'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$(_pp_cond '<' '⇣')
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$(_pp_cond '>' '⇡')
  typeset -g POWERLEVEL9K_VCS_STASH_ICON='*'
  typeset -g POWERLEVEL9K_VCS_TAG_ICON=' '

  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=none
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$(_pp_cond 001 009)
  typeset -g POWERLEVEL9K_CARRIAGE_RETURN_ICON=

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=none
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$(_pp_cond 005 101)
  typeset -g POWERLEVEL9K_EXECUTION_TIME_ICON=

  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=none
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_COLOR=002
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_ICON=$(_pp_cond '%%' '☰')

  typeset -g POWERLEVEL9K_CUSTOM_RPROMPT=custom_rprompt
  typeset -g POWERLEVEL9K_CUSTOM_RPROMPT_BACKGROUND=none
  typeset -g POWERLEVEL9K_CUSTOM_RPROMPT_FOREGROUND=$(_pp_cond 004 012)

  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,ROOT,REMOTE_SUDO,REMOTE,SUDO}_BACKGROUND=none
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,REMOTE_SUDO,REMOTE,SUDO}_FOREGROUND=$(_pp_cond 007 244)
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$(_pp_cond 003 011)

  function custom_rprompt() {}  # redefine this to show stuff in custom_rprompt segment

  unfunction _pp_cond
} "$@"
