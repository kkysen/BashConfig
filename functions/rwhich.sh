rwhich() {
    # I want to use `which`, not `command -v`, because I can do `which -a` this way
    # shellcheck disable=SC2230
    which "${@}" | map realpath
}

export -f rwhich
