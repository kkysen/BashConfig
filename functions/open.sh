function open() {
	cmd.exe /c start "Launching from WSL" "$*"
}

export -f open
