findLast() {
    local timeType="${1}"
    local dir="${2}"
    local findArgs="${3}"
    local openArgs="${4}"

    if [[ "${timeType}" == "" ]]; then
        last
        return $?
    fi

    # shellcheck disable=SC2086
    mapOpenWith "${dir}" "${openArgs}" < <(cd "${dir}" && last -0 "${timeType}" . $findArgs | skim --read0)
}
