removeOldFiles() {
    local dir="${1}"
    local days="${2}"

    local timeFormat="a"
    local noatime=$(fs "${dir}" options | rg noatime)
    if [[ "${noatime}" != "" ]]; then
        timeFormat="m"
    fi

    find "${dir}" -type f,l,p,s "-${timeFormat}time" "+${days}" -delete
}

cleanTmp() {
    local days="${1-10}"
    removeOldFiles /tmp "${days}"
}

export -f removeOldFiles
export -f cleanTmp
