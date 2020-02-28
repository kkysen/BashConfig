browserAt() {
    local browserPath="${1}"
    local path="${2}"
    local winPath=$(wslpath -m "${path}")
    "${browserPath}" "${winPath}"
}

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

browse() {
    local browser="${1}"
    local path=$(browserPath "${browser}") || exit 1
    if [[ "${path}" == "" ]]; then
        return 1
    fi
    browserAt "${path}" "${@:2}"
}

chrome() {
    browse chrome "${@}"
}

firefox() {
    browse firefox "${@}"
}

brave() {
    browse brave "${@}"
}

edge() {
    browse edge "${@}"
}

export -f browserPath
export -f browse
export -f chrome
export -f firefox
export -f brave
export -f edge
