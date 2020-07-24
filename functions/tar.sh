tar-xz() {
    local dir="${1}"
    local name=$(basename "${dir}")
    tar cfJ "${name}.tar.xz" "${dir}"
}

export -f tar-xz
