# TODO change this to the Rust version
locate() {
    command locate \
        -d "${HOME}/mnt.c.Users.db" \
        -d "${HOME}/mnt.c.Program Files.db" \
        -d "${HOME}/mnt.c.Program Files (x86).db" \
        -d "/var/lib/mlocate/mlocate.db" \
        ${@}
}

export -f locate
