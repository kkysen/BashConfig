music() {
    fopen ${ONE_MUSIC}
}

yt2mp3() {
    youtube-dl --extract-audio --audio-format mp3 -o "${ONE_MUSIC}/%(title)s.%(ext)s" ${@}
}

export -f music
export -f yt2mp3
