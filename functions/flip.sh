flip() {
    if [[ ${#} -ne 3 ]]; then
        echo >&2 "usage: flip <cmd> <arg1> <arg2>"
        return 1
    fi
    local cmd="${1}"
    local arg1="${2}"
    local arg2="${3}"
    "${cmd}" "${arg2}" "${arg1}"
}

export -f flip
