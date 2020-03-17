weather() {
    local url="wttr.in/${@}"
    curl -s "${url}" | rg -v "New feature" | rg -v Follow
}

export -f weather
