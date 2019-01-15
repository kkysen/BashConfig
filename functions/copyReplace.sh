# replace a directory with a copy of itself
# on WSL, automatically makes all directories case-sensitive
copyReplace() {
	if [ $# -ne 1 ]; then
		echo "usage: ${FUNCNAME[0]} <directory>"
		return 1;
	fi
	
	local dir=${1}
	if [ ! -d "${dir}" ]; then
		echo "directory doesn't exist: ${dir}"
		return 1;
	fi
	
	local tmp=$(mktemp -d ${dir}.tmp.XXXXXX)
	cp -r ${dir} ${tmp} \
		&& rm -rf ${dir}
	mv ${tmp}/${dir} ${dir} \
		&& rm -rf ${tmp}
}

export -f copyReplace