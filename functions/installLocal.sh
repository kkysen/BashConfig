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
    path=$(realpath "${path}")
    if isWindowsExe "${path}"; then
        # WSL can't run a Windows exe through a symlink
        # see https://github.com/microsoft/WSL/issues/3999
        local execScriptPath="${WORKSPACE_BIN}/$(basename "${path}")"
        printf "#! /bin/bash\nrun \"%s\" \"\${@}\"" "${path}" > "${execScriptPath}"
    else
        ln -s "${path}" "${WORKSPACE_BIN}"
    fi
}

export -f installLocal

uninstallLocal() {
    local program="${1}"
    rm "${WORKSPACE_BIN}/$(basename "${program}")"
}

export -f uninstallLocal

uninstallLocal_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    (cd "${WORKSPACE_BIN}" && compgen -f -- "${arg}")
}

uninstallLocal_complete() {
    compReply uninstallLocal_compgen
}

complete -F uninstallLocal_complete uninstallLocal
