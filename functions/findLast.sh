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
    mapOpenWith "${dir}" "${openArgs}" < <(cd "${dir}" && last -0 "${timeType}" . $findArgs | skim --read0)
}

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
