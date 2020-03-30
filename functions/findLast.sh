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

findLast() {
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

findLastCreated() {
    findLast created "${@}"
}

findLastModified() {
    findLast modified "${@}"
}

findLastAccessed() {
    findLast accessed "${@}"
}

export -f findLast
export -f findLastCreated
export -f findLastModified
export -f findLastAccessed
