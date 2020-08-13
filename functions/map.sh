map() {
    local i=0
    while read -r line; do
        i=${i} "${@}" "${line}"
        ((i++))
    done
}

export -f map
