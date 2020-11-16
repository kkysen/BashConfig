j() {
    just "${@}"
}

export -f j

just_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -eq 1 ]]; then
        compgen -W "$(just --summary)" -- "${arg}"
        compgen -W "$(just --list | rg alias | awk '{print $1}')" -- "${arg}"
    else
        compgen -A file -- "${arg}"
    fi
}

just_complete() {
    compReply just_compgen
}

complete -o filenames -F just_complete just
complete -o filenames -F just_complete j
