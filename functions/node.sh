node_mjs() {
    node --no-warnings --experimental-modules ${@}
}

export -f node_mjs
