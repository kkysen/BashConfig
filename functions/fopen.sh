fopen() {
    # find a file using sk and open it
    local dir=${1}
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
    local winPath=$(wslpath -m "${path}")
    open "${winPath}"
}

export -f fopen
