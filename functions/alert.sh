alert() {
	eval "${@}"
	notify "-Text \"${@}\""
}

export -f alert
