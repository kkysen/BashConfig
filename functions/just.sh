j() {
    just "${@}"
}

export -f j

just_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -eq 1 ]]; then
        compgen -W "$(just --summary)" -- "${arg}"
    fi
}

just_complete() {
    compReply just_compgen
}

complete -F just_complete just
complete -F just_complete j
