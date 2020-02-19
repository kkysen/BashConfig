# https://www.shellhacks.com/tune-command-line-history-bash/#comments

# Save all lines unconditionally
export HISTCONTROL=

# append to the history file, don't overwrite it
shopt -s histappend

export HISTSIZE=10000
export HISTFILESIZE=-1

export HISTTIMEFORMAT="%c "

# save history even when shell crashes
if [ -z "${PROMPT_COMMAND}" ]; then
  export PROMPT_COMMAND="history -a; history -n"
else
  export PROMPT_COMMAND="${PROMPT_COMMAND}; history -a;  history -n"
fi

export HISTFILE="${BASH_DIR}/bash_history.txt"

alias ignore=""
alias i=ignore
export HISTIGNORE=ignore
