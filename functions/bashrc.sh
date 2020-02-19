bashrc() {
	if [[ "${1}" == "edit" ]]; then
		code $BASH_DIR
	else
		. ~/.bashrc
	fi
}

export -f bashrc
