win() {
    local exe="${1}"
    "${exe}.exe" "${@:2}"
}

exeCommands() {
    commands --functions --path | rg "^(.*)\.exe$" --replace '$1'
}

win_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    compgen -W "$(exeCommands)" -- "${arg}"
}

win_complete() {
    compReply win_compgen
}

complete -F win_complete win
