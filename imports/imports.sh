importConfigs() {
    import "${FUNCTIONS}" "${IMPORTS}/configs.functions.txt"
    import "${CONFIGS}" "${IMPORTS}/configs.txt"

    # If not running interactively, don't do anything
    case $- in
        *i*) ;;
        *) return ;;
    esac

    import "${CONFIGS}" "${IMPORTS}/configs.interactive.txt"

    setPath
}

importFunctions() {
    import "${FUNCTIONS}" "${IMPORTS}/functions.txt"
    dedupePrompt
}

importAll() {
    importConfigs
    importFunctions
}

export -f importConfigs
export -f importFunctions
export -f importAll

export PATH="${WORKSPACE}/bin:${PATH}" # fnm on path
. "${CONFIGS}/fnm.sh"                  # correct node version on path
. "${FUNCTIONS}/node.sh"               # node_mjs for import
. "${FUNCTIONS}/import.sh"             # import func
importAll
