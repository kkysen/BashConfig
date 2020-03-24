locateFirst() {
	locate "${@}" | head -n 1
}

export -f locateFirst
