path() {
    echo "${PATH}" | sd -s ':' $'\n'
}

dedupePath() {
    dedupeVar PATH ':' --no-trailing-delimiter
}

export -f path
export -f dedupePath
