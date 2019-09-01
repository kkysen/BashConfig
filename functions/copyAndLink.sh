copyAndLink() {
	echo TODO
	return 1
	local argc=${N}
	# TODO check argc
	local srcDir=${1}
	local destDir=${2}
	mkdir -p "${destDir}"
	cp -r "${srcDir}" "${destDir}"
#	ln -s # TODO
}

export -f copyAndLink
