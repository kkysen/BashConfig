
work() {
    fo "${WORKSPACE}" "${@}"
}

one() {
    fo "${ONE}" "${@}"
}

downloads() {
    fo "${DOWNLOADS}" "${@}"
}

misc() {
    fo "${ONE_MISC}" "${@}"
}

music() {
    fo "${ONE_MUSIC}" "${@}"
}

video() {
    fo "${ONE_VIDEO}" "${@}"
}

export -f work
export -f one
export -f downloads
export -f misc
export -f music
export -f video
