selectAndKill() {
    pselect | xargs --no-run-if-empty "kill"
}

kill() {
    if [[ $# -eq 0 ]]; then
        selectAndKill
    else
        command kill "${@}"
    fi
}

export -f kill
