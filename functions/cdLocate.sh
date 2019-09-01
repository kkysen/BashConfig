cdLocate() {
	cd "$(locateFirst "${1}")" || exit
}

export -f cdLocate
