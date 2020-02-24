ring() {
	eval "${@}"
	notify "-Text \"${@}\" -Sound \"Alarm2\" -SnoozeAndDismiss"
}

export -f ring
