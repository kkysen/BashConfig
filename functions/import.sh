import() {
    if [[ $# -ne 2 ]]; then
        echo >&2 "Usage: ${FUNCNAME[0]} <dir> <importFile>"
        return 1
    fi

    local dir="${1}"
    local importFile="${2}"

    if [[ ! -d "${dir}" ]]; then
        echo >&2 "\"${dir}\" is not a directory"
        return 1
    fi
    if [[ ! -f "${importFile}" ]]; then
        echo >&2 "\"${importFile}\" is not a file"
        return 1
    fi

    eval "$(node_mjs "${FUNCTIONS}/imports.mjs" "${dir}" "${importFile}")"
}

export -f import
