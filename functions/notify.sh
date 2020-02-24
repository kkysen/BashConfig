notify() {
    powershell.exe "New-BurntToastNotification ${@}"
}

export -f notify
