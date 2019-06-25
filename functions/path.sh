path() {
	echo ${PATH} | tr ":" "\n"
}

export -f path