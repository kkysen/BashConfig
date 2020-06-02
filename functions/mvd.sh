mvEcho() {
    echo "mv ${1} ${2}"
    mv "${1}" "${2}"
}

mvd() {
    # shellcheck disable=SC2153
    local downloads="${DOWNLOADS}"
    if [[ "$#" -eq 0 ]]; then
        downloads mvTo .
    elif [[ "$#" -eq 1 ]]; then
        if [[ "${1}" == "--help" ]]; then
            echo "Usage: ${FUNCNAME[0]} [destDir] [files in ${downloads}]" 1>&2
            return 1
        fi
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

export -f mvd

mvd_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    cd "${DOWNLOADS}" && compgen -fd -- "${arg}"
}

mvd_complete() {
    compReply mvd_compgen
}

complete -F mvd_complete mvd
