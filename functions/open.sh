function open() {
	cmd.exe /c start "Launching from bash" "$*"
}

export -f open
