viki() {
    youtube-dl --write-sub --sub-lang en --embed-subs -o "%(title)s.%(ext)s" "${@}"
}

export -f viki
