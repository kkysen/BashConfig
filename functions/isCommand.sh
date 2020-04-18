isCommand() {
    command -v "${@}" > /dev/null
}

export -f isCommand
