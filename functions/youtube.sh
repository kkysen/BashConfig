yt2() {
    local func="${1}"
    callerIndex=2 googleSearchAndThen "https://www.youtube.com/watch?v=" "${func}" "${@:2}"
}

yt2mp3Url() {
    local url="${1}"
    youtube-dl --extract-audio --audio-format mp3 -o "${ONE_MUSIC}/%(title)s.%(ext)s" "${url}"
}

yt2mp3() {
    yt2 yt2mp3Url "${@}"
}

yt2mp3 complete

export -f yt2mp3Url
export -f yt2mp3

yt2mp4Url() {
    local url="${1}"
    youtube-dl --format 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o "${ONE_VIDEO}/%(title)s.%(ext)s" "${url}"
}

yt2mp4() {
    yt2 yt2mp4Url "${@}"
}

yt2mp4 complete

export -f yt2mp4Url
export -f yt2mp4
