guiAt() {
    local guiPath="${1}"
    local path="${2}"
    local winPath=$(wslpath -m "${path}")
    "${guiPath}" "${winPath}" &
}

export -f guiAt

notepad() {
    guiAt "/mnt/c/Program Files (x86)/Notepad++/notepad++.exe" "${@}"
}

export -f notepad
