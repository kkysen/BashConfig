export SKIM="echo . && fd"

skim() {
    local dir="${DIR-.}"
    cd "${dir}"
    SKIM_DEFAULT_COMMAND="${SKIM}" command sk "${@}"
    cd ~-
}

sk() {
    skim "${@}"
}

export -f skim
export -f sk
