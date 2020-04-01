
work() {
    fo "${WORKSPACE}" "${@}"
}

one() {
    fo "${ONE}" "${@}"
}

downloads() {
    findLast accessed "${DOWNLOADS}" "-type f" "${*}"
}

misc() {
    findLast accessed "${ONE_MISC}" "-type f" "${*}"
}

music() {
    findLast accessed "${ONE_MUSIC}" "-type f" "${*}"
}

video() {
    findLast accessed "${ONE_VIDEO}" "${*}"
}

export -f work
export -f one
export -f downloads
export -f misc
export -f music
export -f video
