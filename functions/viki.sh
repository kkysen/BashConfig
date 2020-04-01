vikiUrl() {
    local url="${1}"
    local title=$(curl -s -L "${url}" | rg "<title>" | awk -F ' - ' '{print $1}' | awk -F '<title>' '{print $2}')
    local dir="${ONE_VIDEO}/${title}"
    mkdir -p "${dir}"
    cd "${dir}"
    youtube-dl --write-sub --sub-lang en --embed-subs -o "%(title)s.%(ext)s" "${url}"
    cd ~-
}

viki() {
    googleSearchAndThen "viki.com/tv/" vikiUrl "${@}"
}

export -f viki
