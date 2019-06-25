locateFirst() {
	locate "${1}" | head -n 1
}

export -f locateFirst
