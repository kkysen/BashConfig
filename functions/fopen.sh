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
        local winPath=$(wslpath -m "${path}")
        open "${winPath}"
    else
        ${opener} "${path}"
    fi
}

export -f fopen
alias fo=fopen
