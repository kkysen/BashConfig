mvEcho() {
    echo "mv ${1} ${2}"
    mv "${1}" "${2}"
}

mvd() {
    local dir="${1-.}"
    downloads mvTo "${dir}"
}

export -f mvd
