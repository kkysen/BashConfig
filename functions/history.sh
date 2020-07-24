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
export HISTIGNORE="ignore *"

historyToPurge() {
    history | "${@}"
    history 1 # purge the purging command
}

doPurgeHistory() {
    # uniq to delete potential repeat of last command
    # tac to reverse indices so that indices aren't moved after removing each one
    map history -d < <(historyToPurge "${@}" | awk '{print $1}' | uniq | tac)
    history -w
}

purgeHistory() {
    echo "Purging history that matches '${*}'"
    echo
    historyToPurge "${@}"
    echo
    echo "Can I purge these commands? [y/N]"
    read -r confirmation
    if [[ "${confirmation}" =~ ^(yes|y)$ ]]; then
        doPurgeHistory "${@}"
        echo "Purged"
    else
        echo "Cancelled"
    fi
}

export -f historyToPurge
export -f purgeHistory
