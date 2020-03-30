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
    local dir="${DIR}"
    if [[ ${#} -eq 0 ]]; then
        return 1
    fi
    local opener=("${@:1:${#}-1}")
    local path="${!#}"
    if [[ "${dir}" != "" ]]; then
        path="${dir}/${path}"
    fi
    if [[ ${#opener[@]} -eq 0 ]]; then
        if [[ -d "${path}" ]]; then
            recordRun cd "${path}"
        else
            winOpen "${path}"
        fi
    else
        recordRun "${opener[@]}" "${path}"
    fi
}

mapOpenWith() {
    map openWith "${@}"
}

findOpen() {
    # need to use process substitution b/c openWith may cd
    # process substition is also usually faster than piping
    mapOpenWith "${@}" < <(skim)
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
