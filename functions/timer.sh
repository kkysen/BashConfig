timer() {
    local timeLength=("${@}")
    browse "google.com/search?q=timer ${timeLength[*]}"
}

export -f timer
