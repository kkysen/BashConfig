chrome() {
    local path=${1}
    local winPath=$(wslpath -m "${path}")
    "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "${winPath}"
}

export -f chrome
