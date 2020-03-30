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

fopen() {
    # need to use process substitution b/c openWith may cd
    # process substition is also usually faster than piping
    mapOpenWith "${@}" < <(skim)
}

fo() {
    fopen "${@}"
}

export -f openWith
export -f mapOpenWith
export -f fopen
export -f fo

work() {
    fo "${WORKSPACE}" "${@}"
}

one() {
    fo "${ONE}" "${@}"
}

fopenLastModified() {
    local dir="${1}"
    findLastModified "${dir}" | SKIM_DEFAULT_OPTIONS="--read0" fo . "${@:2}"
}

downloads() {
    fo "${DOWNLOADS}" "${@}"
}

misc() {
    fo "${ONE_MISC}" "${@}"
}

music() {
    fo "${ONE_MUSIC}" "${@}"
}

video() {
    fo "${ONE_VIDEO}" "${@}"
}

export -f work
export -f one
export -f downloads
export -f misc
export -f music
export -f video
