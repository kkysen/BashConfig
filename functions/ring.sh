ring() {
	if [ $# -gt 0 ]; then
		eval ${@};
	fi
	for i in {1..100}; do
		tput bel;
		sleep 2; 
	done
}

export -f ring