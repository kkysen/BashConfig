lastAll() {
    local timeType="${1}"
    local findArgs="${2}"
    # shellcheck disable=SC2086
    last -0 "${timeType}" . $findArgs
    printf "\0"
    # shellcheck disable=SC2086
    last -0 "${timeType}" . '!' \( $findArgs \)
}

findLast() {
    local timeType="${1}"
    local dir="${2}"
    local findArgs="${3}"
    local openArgs="${4}"

    if [[ "${timeType}" == "" ]]; then
        last
        return $?
    fi

    # shellcheck disable=SC2086
    mapOpenWith "${dir}" "${openArgs}" < <(cd "${dir}" && lastAll "${timeType}" "${findArgs}" | skim --read0)
}

export -f findLast

findLast_compgen() {
    local i="${1}"
    local arg="${2}"
    case ${i} in
        1)
            compgen -W "$(last --times)" -- "${arg}"
            ;;
        2)
            compgen -d -- "${arg}"
            ;;
    esac
}

findLast_complete() {
    compReply findLast_compgen
}

complete -F findLast_complete findLast
