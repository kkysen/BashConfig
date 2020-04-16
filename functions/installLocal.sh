installLocal() {
    local rawPath="${1}"
    local path="${rawPath}"
    if [[ ! -x "${rawPath}" ]]; then
        if ! path=$(command -v "${rawPath}"); then
            echo >&2 "${rawPath} is not an executable or in \$PATH"
            return 1
        fi
        if [[ "${path}" == "${WORKSPACE_BIN}/${rawPath}" ]]; then
            echo >&2 "${rawPath} is already in ${WORKSPACE_BIN}"
            return 1
        fi
    fi
    ln -s "$(realpath "${path}")" "${WORKSPACE_BIN}"
}

export -f installLocal

uninstallLocal() {
    local program="${1}"
    rm "${WORKSPACE_BIN}/${program}"
}

export -f uninstallLocal
