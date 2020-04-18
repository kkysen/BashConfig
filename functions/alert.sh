alert() {
    "${@}"
    notify "-Text \"${*}\""
}

export -f alert
