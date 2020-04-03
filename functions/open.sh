open() {
    cmd.exe /c start "Launching from WSL" "$*"
}

export -f open

open_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    compgen -fd -- "${arg}"
}

open_complete() {
    compReply open_compgen
}

complete -F open_complete open
