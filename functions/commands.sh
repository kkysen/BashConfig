functionCommands() {
    declare -F | awk -F" " '{print $3}'
}

pathCommands() {
    onPath --filenames
}

commands() {
    local builtins=false
    local aliases=false
    local functions=false
    local path=false

    while [[ $# -gt 0 ]]; do
        case "${1}" in
            --builtins)
                builtins=true
                ;;
            --aliases)
                aliases=true
                ;;
            --functions)
                functions=true
                ;;
            --path)
                path=true
                ;;
            --all | "")
                builtins=true
                aliases=true
                functions=true
                path=true
                ;;
        esac
        shift
    done

    local compgenFlags="-"
    if ${builtins}; then
        compgenFlags+="b"
    fi
    if ${aliases}; then
        compgenFlags+="a"
    fi
    compgen "${compgenFlags}"

    if ${functions}; then
        functionCommands
    fi

    if ${path}; then
        pathCommands
    fi
}

export -f commands
