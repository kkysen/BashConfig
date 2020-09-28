map() {
    local i=0
    while read -r line; do
        i=${i} "${@}" "${line}"
        ((i++))
    done
}

export -f map

mapArgs() {
    local i=0
    while read -r line; do
        # shellcheck disable=SC2086
        i=${i} "${@}" ${line}
        ((i++))
    done
}

export -f mapArgs
