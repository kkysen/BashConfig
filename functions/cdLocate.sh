cdLocate() {
	cd "$(locateFirst "${1}")"
}

export -f cdLocate
