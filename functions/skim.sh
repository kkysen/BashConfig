export SKIM="echo . && fd"

skim() {
    if [[ "${1}" == "--dir" ]]; then
        local dir="${2}"
        shift
        shift
    else
        local dir=""
    fi
    (cd "${dir}" && SKIM_DEFAULT_COMMAND="${SKIM}" command sk --multi "${@}")
}

sk() {
    skim "${@}"
}

export -f skim
export -f sk
