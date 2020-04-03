# https://www.shellhacks.com/tune-command-line-history-bash/#comments

# Save all lines unconditionally
export HISTCONTROL=

# append to the history file, don't overwrite it
shopt -s histappend

export HISTSIZE=1000000000
export HISTFILESIZE=-1

export HISTTIMEFORMAT="%c "

# save history even when shell crashes
saveHistory() {
    history -a
    history -n
}

export -f saveHistory

addPrompt saveHistory

export HISTFILE="${DATA_DIR}/bash_history.txt"

alias ignore=""
alias i=ignore
export HISTIGNORE=ignore
