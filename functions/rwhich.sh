rwhich() {
    # I want to use `which`, not `command -v`, because I can do `which -a` this way
    # shellcheck disable=SC2230
    which "${@}" | map realpath
}

export -f rwhich

rwhich_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    compgen -W "$(commands --path)" -- "${arg}"
}

rwhich_complete() {
    compReply rwhich_compgen
}

complete -F rwhich_complete rwhich
