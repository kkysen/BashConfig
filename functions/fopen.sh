fopen() {
    # find a file using sk and open it
    local dir=${1}
    local opener=${2}

    if [[ "${dir}" == "" ]]; then
        dir="."
    fi
    cd "${dir}"
    local file=$(sk)
    cd ~-
    if [[ "${file}" == "" ]]; then
        return
    fi
    local path="${dir}/${file}"
    if [[ "${opener}" == "" ]]; then
        if [[ -d "${path}" ]]; then
            if [[ "${dir}" == "." ]]; then
                open .
            else
                cd "${path}"
            fi
        else
            local winPath=$(wslpath -m "${path}")
            open "${winPath}"
        fi
    else
        ${opener} "${path}"
    fi
}

fo() {
    fopen ${@}
}

export -f fopen
export -f fo

music() {
    fopen ${ONE_MUSIC} ${@}
}

one() {
    fo ${ONE} ${@}
}

downloads() {
    fo ${DOWNLOADS} ${@}
}

export -f music
export -f one
export -f downloads
