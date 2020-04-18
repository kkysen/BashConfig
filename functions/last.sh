convertTimeToPrintf() {
    local timeType="${1}"
    case "${timeType}" in
        created)
            echo "C"
            ;;
        modified)
            echo "T"
            ;;
        accessed)
            echo "A"
            ;;
        *)
            echo "created modified accessed"
            return 1
            ;;
    esac
}

lastRaw() {
    local timeFormat="${1}"
    printf ".\0"
    find "${@:2}" -printf "%${timeFormat}s\t%p\0" |
        sort -nrz |
        cut -f2 -z
}

last() {
    local null="${1}"
    case "${null}" in
        --null | -0)
            local delim='\0'
            shift
            ;;
        --times)
            convertTimeToPrintf
            return
            ;;
        *)
            local delim='\n'
            ;;
    esac
    local timeType="${1}"
    local timeFormat
    if ! timeFormat=$(convertTimeToPrintf "${timeType}"); then
        echo >&2 "timeType must be one of [${timeFormat}]"
        return 1
    fi

    # huniq removes duplicate "."
    lastRaw "${timeFormat}" "${@:2}" |
        huniq -0 |
        tr '\0' "${delim}"
}

export -f last

last_compgen() {
    local i="${1}"
    local arg="${2}"
    # good enough
    if [[ ${i} -eq 1 ]]; then
        compgen -W "--null -0 --times" -- "${arg}"
    fi
    compgen -W "$(last --times)" -- "${arg}"
}

last_complete() {
    compReply last_compgen
}

complete -F last_complete last
