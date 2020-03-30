path() {
    echo "${PATH}" | sd -s ':' $'\n'
}

export -f path
