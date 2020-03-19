export SKIM="echo . && fd"

skim() {
    SKIM_DEFAULT_COMMAND="${SKIM}" command sk "${@}"
}

sk() {
    skim "${@}"
}

export -f skim
export -f sk
