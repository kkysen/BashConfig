guiAt() {
    ("${@}" &) 2>/dev/null
}

export -f guiAt

notepad() {
    guiAt "/mnt/c/Program Files (x86)/Notepad++/notepad++.exe" "${@}"
}

export -f notepad
