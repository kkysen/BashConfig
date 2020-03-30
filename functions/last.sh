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

last() {
    local timeType="${1}"
    local dir="${2-.}"
    local timeFormat
    if ! timeFormat=$(convertTimeToPrintf "${timeType}"); then
        echo >&2 "timeType must be one of [${timeFormat}]"
        return 1
    fi
    if [[ -t 1 ]]; then
        local delim='\n'
    else
        local delim='\0'
    fi
    find "${dir}" "${@:3}" -printf "%${timeFormat}s\t%p\0" \
        | sort -nrz \
        | cut -f2 -z \
        | tr '\0' "${delim}"
}

lastCreated() {
    last created "${@}"
}

lastModified() {
    last modified "${@}"
}

lastAccessed() {
    last accessed "${@}"
}

export -f last
export -f lastCreated
export -f lastModified
export -f lastAccessed
