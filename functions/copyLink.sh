copyLink() {
	local link=${1}
	local dir=$(readlink ${link})
	set -e
	rm ${link}
	cp -r ${dir} ${link}
}

export -f copyLink
