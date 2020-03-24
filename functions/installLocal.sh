installLocal() {
    local path="${1}"
    ln -s "${path}" "${WORKSPACE_BIN}"
}

export -f installLocal
