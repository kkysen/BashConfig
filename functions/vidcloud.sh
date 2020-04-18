vidcloud() {
    local url="${1}"
    local episode=$(echo "${url}" | sed "s/.*sub\.\([0-9]\+\)\.m3u8/\1/g")
    if [[ "${episode}" == "" ]]; then
        local episodeArg=""
    else
        local episodeArg="-o \"E${episode}.%(ext)s\""
    fi
    youtube-dl --referer "https://vidcloud9.com/" "${episodeArg}" "${@}"
}

export -f vidcloud
