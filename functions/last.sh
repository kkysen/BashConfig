convertTimeToPrintf() {
    local timeType="${1}"
    case "${timeType}" in
        created | c)
            echo "C"
            ;;
        modified | m)
            echo "T"
            ;;
        accessed | a)
            echo "A"
            ;;
        *)
            echo "c | created | m | modified | a | accessed"
            return 1
    esac
}

lastRaw() {
    local timeFormat="${1}"
    printf ".\0"
    find "${@:2}" -printf "%${timeFormat}s\t%p\0" \
        | sort -nrz \
        | cut -f2 -z
}

last() {
    local null="${1}"
    case "${null}" in
        --null | -0)
            local delim='\0'
            shift
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
    lastRaw "${timeFormat}" "${@:2}" \
        | huniq -0 \
        | tr '\0' "${delim}"
}

export -f last
