cdAny() {
    # cd to a directory or to the parent directory if it's a file
    local dir="${1}"
    if [[ -d "${dir}" ]]; then
        cd "${dir}" || return 1
    else
        cd "$(dirname "${dir}")" || return 1
    fi
}
