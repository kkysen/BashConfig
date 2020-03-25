ideList() {
    echo code
    echo notepad++
    jetBrainsIdeNames
}

ide() {
    local ide="${IDE}"
    if [[ "${ide}" == "" ]]; then
        ide=$(ideList | skim)
        if [[ "${ide}" == "" ]]; then
            return 1
        fi
    fi
    case "${ide}" in
        code)
            # special case since vs code works w/ WSL
            code "${@}"
            ;;
        notepad++)
            notepad "${@}"
            ;;
        # TODO other special cases
        *)
            # JetBrains IDEs
            if jetBrainsIde "${ide}" "${@}"; then
                return
            fi
            # TODO other general cases
            ;;
    esac
}

export -f ideList
export -f ide
