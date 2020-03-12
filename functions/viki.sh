viki() {
    local subCommand="${1}"
    case "${subCommand}" in
        url)
            local url="${2}"
            ;;
        code)
            local code="${2}"
            local url="viki.com/tv/${code}"
            ;;
        search)
            local search="${@:2}"
            local url=$(googler "Viki ${search}" --json | js 'a => a.map(e => e.url).find(e => e.includes("viki.com/tv"))')
            ;;
        *)
            >&2 echo "Usage: ${FUNCNAME[0]} [url | code | search] <arg>"
			return 1
			;;
    esac
    
    local title=$(curl -s -L "${url}" | rg "<title>" | awk -F ' - ' '{print $1}' | awk -F '<title>' '{print $2}')
    local dir="${ONE_VIDEO}/${title}"
    mkdir -p "${dir}"
    cd "${dir}"
    youtube-dl --write-sub --sub-lang en --embed-subs -o "%(title)s.%(ext)s" "${url}"
    cd ~-
}

export -f viki
