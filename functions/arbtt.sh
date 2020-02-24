ARBTT_DIR="${APP_DATA}/Roaming/arbtt"

arbtt() {
    arbtt-stats --logfile="${ARBTT_DIR}/capture.log" --categorizefile="${ARBTT_DIR}/categorize.cfg" ${@}
}

export -f arbtt
