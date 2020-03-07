openAll() {
    for path in "${@}"; do
        open "${path}"
    done
}

export -f openAll
