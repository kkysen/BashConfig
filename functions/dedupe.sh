# TODO rewrite dedupe in Rust

dedupeWithTrailingDelimiter() {
    # huniq requires a single character delimiter
    # so I need to switch from ${delim} to a single character delimiter
    # I would've used '\0', but I can't pass this on the command line to sd
    # sd could use "\x00", but that enables regexes, which messes with escaping ${delim}
    # so I chose '\1', which should be uncommon
    local delim="${1}"
    local internalDelim=$'\1'
    sd --string-mode "${delim}" "${internalDelim}" |
        huniq -d "${internalDelim}" |
        sd --string-mode "${internalDelim}" "${delim}"
}

dedupe() {
    if [[ ${#} -lt 1 ]]; then
        echo >&2 "Usage: ${FUNCNAME[0]} <var> [--trailing-delimiter | --no-trailing-delimiter]"
        return 1
    fi
    local delim="${1}"
    local printTrailingDelimiter="${2}"
    case "${printTrailingDelimiter}" in
        --no-trailing-delimiter)
            local trailingDelimiter=false
            ;;
        --trailing-delimiter | *)
            local trailingDelimiter=true
            ;;
    esac
    local deduped="$(dedupeWithTrailingDelimiter "${delim}")"
    if ! ${trailingDelimiter}; then
        local trailing="${deduped: -${#delim}}"
        if [[ "${trailing}" == "${delim}" ]]; then
            deduped="${deduped:0:-${#delim}}"
        fi
    fi
    printf "%s" "${deduped}"
}

dedupeVar() {
    if [[ ${#} -lt 2 ]]; then
        echo >&2 "Usage: ${FUNCNAME[0]} <var> <delim>"
        return 1
    fi
    local var="${1}"
    export "${var}"="$(printf "%s" "${!var}" | dedupe "${@:2}")"
}

export -f dedupe
export -f dedupeVar
