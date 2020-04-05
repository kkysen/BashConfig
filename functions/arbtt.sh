ARBTT_DIR="${APP_DATA}/Roaming/arbtt"

ARBTT_BIN="${PROGRAM_FILES_X86}/arbtt/bin"

arbttRaw() {
    local command="${1}"
    local path="${ARBTT_BIN}/arbtt-${command}.exe"
    "${path}" "${@:2}"
}

export -f arbttRaw

arbttRaw_compgen() {
    fd --base-directory "${ARBTT_BIN}" "arbtt" \
        | sd "arbtt-(.*)\.exe" '$1'
}

arbttRaw_complete() {
    compReply arbttRaw_compgen
}

complete -F arbttRaw_complete arbttRaw

arbtt() {
#    arbttRaw stats --logfile="${ARBTT_DIR}/capture.log" --categorizefile="${ARBTT_DIR}/categorize.cfg" "${@}"
    # TODO format this better w/ categorize.cfg if I want better stats
    arbttRaw stats "${@}"
}

export -f arbtt
