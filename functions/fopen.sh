recordRun() {
    history -a
    local current="$(tac $HISTFILE | head -n 1)"
    history -s "${@}"
    history -s ${current}
    "${@}"
}

fopen() {
    # find a file using sk and open it
    local dir=${1}
    local opener=${@:2}

    if [[ "${dir}" == "" ]]; then
        dir="."
    fi
    cd "${dir}"
    local file="$(sk)"
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
            if [[ "${dir}" == "." ]]; then
                open .
            else
                cd "${path}"
            fi
        else
            local winPath=$(wslpath -m -a "${path}")
            cd "${WIN}"
            recordRun open "${winPath}"
            cd ~-
        fi
    else
        recordRun ${opener[@]} "${path}"
    fi
}

fo() {
    fopen "${@}"
}

export -f fopen
export -f fo

music() {
    fopen ${ONE_MUSIC} "${@}"
}

one() {
    fo ${ONE} "${@}"
}

downloads() {
    fo ${DOWNLOADS} "${@}"
}

work() {
    fo ${WORKSPACE} "${@}"
}

export -f music
export -f one
export -f downloads
export -f work
