cleanMusicFileNames() {
    local subCommand="${1}"
    local rename="${ONE_MUSIC}/rename.json"
    local renamed="${ONE_MUSIC}/renamed.json"
    case "${subCommand}" in
        run)
            if [[ -f "${rename}" ]]; then
                nomino --map "${rename}" --generate "${renamed}"
                rm "${rename}"
            else
                echo >&2 "'${rename}' does not exist"
                return 1
            fi
            ;;
        undo)
            nomino --map "${renamed}" --generate "${rename}"
            rm "${renamed}"
            ;;
        clean)
            rm -f "${rename}"
            ;;
        generate | *)
            fd -0 --base-directory "${ONE_MUSIC}" |
                js "$(cat "${FUNCTIONS}/cleanMusicFileNames.js")" "${rename}" > /dev/null
            bat "${rename}"
            echo "run '${FUNCNAME[0]} run' to actually rename files in '${rename}'"
            ;;
    esac
}

export -f cleanMusicFileNames
