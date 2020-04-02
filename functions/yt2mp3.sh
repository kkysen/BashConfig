yt2mp3Url() {
    local url="${1}"
    youtube-dl --extract-audio --audio-format mp3 -o "${ONE_MUSIC}/%(title)s.%(ext)s" "${url}"
}

yt2mp3() {
    googleSearchAndThen "https://www.youtube.com/watch?v=" yt2mp3Url "${@}"
}

yt2mp3 complete

export -f yt2mp3
