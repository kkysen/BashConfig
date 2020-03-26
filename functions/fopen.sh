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

fopen() {
    # find a file using sk and open it
    local dir=${1}
    local opener=("${@:2}")

    if [[ "${dir}" == "" ]]; then
        dir="."
    fi
    cd "${dir}"
    local file="$(skim)"
    cd ~-
    if [[ "${file}" == "" ]]; then
        return
    fi
    if [[ "${dir}" == "." ]]; then
        local path="${file}"
    else
        local path="${dir}/${file}"
    fi
    
    if [[ ${#opener[@]} -eq 0 ]]; then
        if [[ -d "${path}" ]]; then
            cd "${path}"
        else
            winOpen "${path}"
        fi
    else
        recordRun "${opener[@]}" "${path}"
    fi
}

fo() {
    fopen "${@}"
}

export -f fopen
export -f fo

work() {
    fo "${WORKSPACE}" "${@}"
}

one() {
    fo "${ONE}" "${@}"
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
