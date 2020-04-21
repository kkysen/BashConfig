moveTo() {
    mv "${2}" "${1}"
}

export -f moveTo

mvTo() {
    moveTo "${@}"
}

export -f mvTo
