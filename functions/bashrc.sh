bashrc() {
	if [[ "${1}" == "edit" ]]; then
		code ${BASH_DIR}
	elif [[ "${1}" == "code" ]]; then
		code ${BASH_DIR}
	elif [[ "${1}" == "cd" ]]; then
		cd ${BASH_DIR}
	elif [[ "${1}" == "go" ]]; then
		cd ${BASH_DIR}
	else
		. ~/.bashrc
	fi
}

export -f bashrc
alias rc=bashrc
