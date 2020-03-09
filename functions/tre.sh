tre() {
    command tre "${@}" -e && . "/tmp/tre_aliases_${USER}" 2>/dev/null
}

export -f tre
