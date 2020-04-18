cdLocate() {
    cd "$(locateFirst "${1}")" || return
}

export -f cdLocate
