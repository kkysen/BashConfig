browserPath() {
    local browser="${1}"
    case "${browser}" in
        chrome)
            echo "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"
            ;;
        firefox)
            echo "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
            ;;
        brave)
            echo "/mnt/c/Program Files (x86)/BraveSoftware/Brave-Browser/Application/brave.exe"
            ;;
        edge)
            >&2 echo "edge not working yet"
            return 1
            ;;
        *)
            >&2 "\"${browser}\" is not a recognized browser"
            return 1
            ;;
    esac
}

# default browsers
export BROWSER=chrome

browse() {
    local browser="${BROWSER}"
    local path=$(browserPath "${browser}") || exit 1
    if [[ "${path}" == "" ]]; then
        return 1
    fi
    guiAt "${path}" "${@}"
}

chrome() {
    BROWSER=chrome browse "${@}"
}

firefox() {
    BROWSER=firefox browse "${@}"
}

brave() {
    BROWSER=brave browse "${@}"
}

edge() {
    BROWSER=edge browse "${@}"
}

export -f browserPath
export -f browse
export -f chrome
export -f firefox
export -f brave
export -f edge
