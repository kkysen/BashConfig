isWindowsExe() {
    local executable="${1}"
    if [[ ! -e "${executable}" ]]; then
        executable=$(command -v "${executable}")
    fi
    local fileType=$(file "${executable}")
    if [[ "${fileType}" == *"Windows"* ]] || [[ "${fileType}" == *"DOS"* ]]; then
        return 0
    else
        return 1
    fi
}

export -f isWindowsExe
