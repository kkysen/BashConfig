importConfigsFunctions() {
    import "${FUNCTIONS}" "${IMPORTS}/configs.functions.txt"
}

importConfigsMain() {
    import "${CONFIGS}" "${IMPORTS}/configs.main.txt"
}

importConfigsInteractive() {
    # If not running interactively, don't do anything
    case $- in
        *i*) ;;
        *) return ;;
    esac

    import "${CONFIGS}" "${IMPORTS}/configs.interactive.txt"
}

importCompletions() {
    import "${GEN_COMPLETIONS}" "${IMPORTS}/completions.txt"
}

importFunctions() {
    import "${FUNCTIONS}" "${IMPORTS}/functions.txt"
}

importAll_usage() {
    echo >&2 "Usage: ${FUNCNAME[0]} <use autocompletion>"
}

importAll() {
    local type="${1}"
    local subType="${2}"

    # only run if importAll is not called from importAll
    if [[ "${FUNCNAME[0]}" == "${FUNCNAME[1]}" ]]; then
        local internal=true
    else
        local internal=false
    fi

    case "${type}" in
        configs | conf)
            case "${subType}" in
                functions | func)
                    importConfigsFunctions
                    ;;
                main)
                    importConfigsMain
                    ;;
                interactive)
                    importConfigsInteractive
                    ;;
                all | "")
                    importAll configs functions
                    importAll configs main
                    importAll configs interactive
                    ;;
                *)
                    importAll_usage
                    return 1
                    ;;
            esac
            # only run if importAll is not called from importAll
            if ! ${internal}; then
                setPath
                dedupePrompt
            fi
            ;;
        functions | func)
            case "${subType}" in
                all | "")
                    importFunctions
                    ;;
                *)
                    importAll_usage
                    return 1
                    ;;
            esac
            # only run if importAll is not called from importAll
            if ! ${internal}; then
                dedupePrompt
            fi
            ;;
        completions | comp)
            case "${subType}" in
                all | "")
                    importCompletions
                    ;;
                *)
                    importAll_usage
                    return 1
                    ;;
            esac
            ;;
        all | "")
            # these are internal calls, so setPath and dedupePrompt won't get run
            importAll configs all
            setPath
            importAll functions all
            dedupePrompt
            # don't do completions here
            ;;
        *)
            importAll_usage
            return 1
            ;;
    esac
}

importAll_compgen() {
    local i="${1}"
    local arg="${2}"

    local conf="configs conf"
    local func="functions func"
    local all="all"
    local main="main"
    local interactive="interactive"

    case ${i} in
        1)
            local type="${arg}"
            compgen -W "${conf} ${func} ${all}" -- "${type}"
            ;;
        2)
            local type="${COMP_WORDS[1]}"
            local subType="${arg}"
            case "${type}" in
                configs | config | conf | c)
                    compgen -W "${func} ${main} ${interactive} ${all}" -- "${subType}"
                    ;;
                functions | function | func | f)
                    compgen -W "${all}" -- "${subType}"
                    ;;
                all | a | "") ;;

                *) ;;

            esac
            ;;
    esac
}

importAll_complete() {
    compReply importAll_compgen
}

complete -F importAll_complete importAll

export -f importAll
