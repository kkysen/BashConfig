map() {
    while read -r line; do
        "${@}" "${line}"
    done
}

export -f map
