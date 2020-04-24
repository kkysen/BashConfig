clipboard() {
    win cbs "${@}"
}

copy() {
    if [[ $# -gt 0 ]]; then
        clipboard copy "${@}"
    else
        clipboard
    fi
}

export -f copy

paste() {
    clipboard paste
}

export -f paste
