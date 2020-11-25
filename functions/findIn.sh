work() {
    fo "${WORKSPACE}" "${*}"
}

one() {
    fo "${ONE}" "${*}"
}

downloads() {
    findLast accessed "${DOWNLOADS}" "-type f" "${*}"
}

misc() {
    findLast accessed "${ONE_MISC}" "-type f" "${*}"
}

music() {
    local timeType="${1}"
    if [[ "${timeType}" == "" ]]; then
        timeType=accessed
    fi
    tryRestoreMusicOrder
    findLast "${timeType}" "${ONE_MUSIC}" "-type f -name *.mp3" "${*:2}"
}

music_compgen() {
    local i="${1}"
    local arg="${2}"
    case ${i} in
        1)
            compgen -W "$(last --times)" -- "${arg}"
            ;;
    esac
}

music_complete() {
    compReply music_compgen
}

complete -F music_complete music

video() {
    findLast accessed "${ONE_VIDEO}" "${*}"
}

export -f work
export -f one
export -f downloads
export -f misc
export -f music
export -f video
