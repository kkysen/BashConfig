crateName() {
    crate-name-cli "${@}"
    if [[ "$#" -eq 0 ]]; then
        echo
    fi
}

export -f crateName
