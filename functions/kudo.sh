kudo() {
    sudo -E env "PATH=${PATH}" ${@}
}

export -f kudo
