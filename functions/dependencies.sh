dependencies() {
    local exe="${1}"
    local path=$(command -v "${exe}")
    if [[ "${exe}" != "/"~ && "${exe}" != "./"~ && "${exe}" == "${path}" ]]; then
        # if command -v doesn't give an executable path, use which
        # shellcheck disable=SC2230
        path=$(which "${exe}")
    fi
    echo "${path}"
    # shellcheck disable=SC2016
    ldd "${path}" | rg '=> (.+) \(' --only-matching --replace '$1'
}

deps() {
    dependencies "${@}"
}

export -f dependencies
export -f deps

sizes() {
    local sort="${1}"
    local sortCmd="cat"
    if [[ "${sort}" == "--sort" ]]; then
        sortCmd="sort --human-numeric-sort"
    fi
    xargs du --dereference --bytes --total --human-readable | ${sortCmd}
}

export -f sizes

depSizes() {
    deps "${1}" | sizes "${2}"
}

export -f depSizes
