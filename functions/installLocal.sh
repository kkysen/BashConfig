installLocal() {
    local path="${1}"
    ln -s "$(realpath "${path}")" "${WORKSPACE_BIN}"
}

export -f installLocal
