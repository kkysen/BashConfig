cleanMusicFileNames() {
    local run="${1}"
    local rename="${ONE_MUSIC}/rename.json"
    if [[ "${run}" == "run" ]]; then
        if [[ -d "${rename}" ]]; then
            nomino --map "${rename}"
        else
            echo >&2 "'${rename}' does not exist"
            return 1
        fi
    else
        fd -0 --base-directory "${ONE_MUSIC}" | js "$(cat "${FUNCTIONS}/cleanMusicFileNames.js")" "${rename}"
        echo "run '${FUNCNAME[0]} run' to actually rename files in '${rename}'"
    fi
}

export -f cleanMusicFileNames
