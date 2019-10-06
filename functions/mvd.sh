mvEcho() {
    echo "mv ${1} ${2}"
    mv "${1}" "${2}"
}

mvd() {
    # shellcheck disable=SC2153
    local downloads="${DOWNLOADS}"
    if [[ "$#" -eq 0 ]]; then
        echo "Usage: mvd [destDir] [files in ${downloads}]"
        return 1
    elif [[ "$#" -eq 1 ]]; then
        local dest="."
        local download="${1}"
        mvEcho "${downloads}/${download}" "${dest}"
    else
        local dest="${1}"
        for download in "${@:2}"; do
            mvEcho "${downloads}/${download}" "${dest}"
        done
    fi
}

mvdComplete() {
    local IFS=$'\n'
    COMPREPLY=($(cd "${DOWNLOADS}" && compgen -f -d "${2}"))
}

export -f mvd
complete -F mvdComplete mvd
