tar-xz() {
    local dir="${1}"
    local name=$(basename "${dir}")
    tar cf - "${dir}" | xz --threads 0 --verbose > "${name}.tar.xz"
}

export -f tar-xz
