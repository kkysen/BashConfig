handleUrls() {
    local pipe="${1}"
    local func="${2}"
    while read -r line; do
        local url="${line}"
        if [[ "${url}" != "" ]]; then
            "${func}" "${url}"
        fi
    done < "${pipe}"
}

googleAndThen() {
    local func="${1}"
    local args=("${@:2}")
    local pipe=$(mktemp -ut googler-url-pipe.XXX)   
    mkfifo "${pipe}" || return 1
    (handleUrls "${pipe}" "${func}" &)
    googler --url-output "${pipe}" "${args[@]}"
    rm -f "${pipe}"
}

googleSearchAndThen() {
    local name="${FUNCNAME[1]}"
    local prefix="${1}"
    local func="${2}"
    local execFunc="${SHELL} -i -c ${func}"
    local subCommand="${3}"
    case "${subCommand}" in
        url)
            local url="${4}"
            "${func}" "${url}"
            ;;
        code)
            local code="${4}"
            local url="${prefix}/${code}"
            "${func}" "${url}"
            ;;
        search)
            local search=("${@:4}")
            googleAndThen "${func}" --site "${prefix}" "${search[@]}"
            ;;
        *)
            >&2 echo "Usage: ${name} [url | code | search] <args>"
			return 1
			;;
    esac
}

export -f googleAndThen
export -f googleSearchAndThen
