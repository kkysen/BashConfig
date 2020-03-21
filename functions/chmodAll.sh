chmodAllOfType() {
    local type="${1}"
    local permissions="${2}"
    local dir="${3:-.}"
    fd -H -I -t "${type}" -0 --search-path "${dir}" | xargs -0 -r chmod "${permissions}"
    if [[ "${type}" == *d* ]]; then
        chmod "${permissions}" .
    fi
}

chmodAll() {
    local dirPermissions="${1}"
    local filePermissions="${2}"
    local dir="${3}"
    chmodAllOfType d "${dirPermissions}" "${dir}"
    chmodAllOfType f "${filePermissions}" "${dir}"
}

chmodAllEveryone() {
    chmodAll 0777 0777 "${@}"
}

chmodAllNormal() {
    chmodAll 0755 0644 "${@}"
}

chmodAllUser() {
    chmodAll 0700 0600 "${@}"
}

chmodAllMin() {
    chmodAll 0500 0000 "${@}"
}

export -f chmodAllOfType
export -f chmodAll
export -f chmodAllEveryone
export -f chmodAllNormal
export -f chmodAllUser
export -f chmodAllMin
