recordRun() {
    history -a
    local current="$(tac "${HISTFILE}" | head -n 1)"
    history -s "${@}"
    history -s "${current}"
    "${@}"
}

winOpen() {
    local path="${1}"
    local winPath=$(wslpath -m -a "${path}")
    cd "${WIN}"
    recordRun open "${winPath}"
    cd ~-
}

openWith() {
    if [[ ${#} -ne 3 ]]; then
        echo >&2 "Usage: ${FUNCNAME[0]} <dir> <opener> <path>"
        return 1
    fi
    local dir="${1}"  # default ""
    local opener="${2}"  # default ""
    local path="${3}"

    if [[ "${dir}" == "" ]]; then
        dir="."
    fi
    if [[ "${opener}" == "" ]]; then
        opener=winOpen
    fi

    if [[ "${dir}" != "." ]]; then
        path="${dir}/${path}"
    fi

    if [[ -d "${path}" ]]; then
        opener="cd"
    fi
    # shellcheck disable=SC2086
    recordRun $opener "${path}"
}

mapOpenWith() {
    local dir="${1}"
    local opener="${2}"
    map openWith "${dir}" "${opener}"
}

findOpen() {
    local dir="${1}"
    local opener="${2}"
    # need to use process substitution b/c openWith may cd
    # process substition is also usually faster than piping
    mapOpenWith "${dir}" "${opener}" "${@:2}" < <(skim --dir "${dir}")
}

fopen() {
    findOpen "${@}"
}

fo() {
    findOpen "${@}"
}

export -f openWith
export -f mapOpenWith
export -f findOpen
export -f fopen
export -f fo
