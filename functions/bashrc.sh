bashrc() {
	local arg="${1}"
	case "${arg}" in
		"edit" | "code")
			code "${BASH_DIR}"
			;;
		"cd" | "go")
			cd "${BASH_DIR}"
			;;
		"")
			. ~/.bashrc
			;;
		"-h" | "-help" | "--help")
			echo "Usage: ${FUNCNAME[0]} [edit | code | cd | go | <bash script in ${FUNCTIONS}>]"
			return 1
			;;
		*)
			# if given a file in ${FUNCTIONS}, reload only that file
			local path="${FUNCTIONS}/${arg}"
			if [[ ! -f "${path}" ]]; then
				echo "\`${path}\` does not exist"
				return 1
			fi
			if [[ ! "${path}" == *.sh ]]; then
				echo "\`${path}\` is not a bash script ending in .sh"
				return 1
			fi
			. "${path}"
			;;
	esac
}

bashrc_complete() {
	COMPREPLY+=($(compgen -W "edit code cd go -h -help --help" -- "${COMP_WORDS[1]}"))
	local IFS=$'\n'
    COMPREPLY+=($(cd "${FUNCTIONS}" && compgen -f -X '!*.sh' -- "${COMP_WORDS[1]}"))
}

rc() {
	bashrc ${@}
}

export -f bashrc
export -f rc

complete -F bashrc_complete bashrc
complete -F bashrc_complete rc
