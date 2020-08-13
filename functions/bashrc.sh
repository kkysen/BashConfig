# TODO allow reloading scripts in ${CONFIGS} as well, not just ${FUNCTIONS}

reloadScript() {
    # if given a file in ${dir}, reload only that file
    local dir="${1}"
    local file="${2}"
    local path="${dir}/${file}"
    if [[ ! -f "${path}" ]]; then
        echo "\`${path}\` does not exist"
        return 1
    fi
    if [[ ! "${path}" == *.sh ]]; then
        echo "\`${path}\` is not a bash script ending in .sh"
        return 1
    fi
    # shellcheck disable=SC1090
    . "${path}"
}

reloadFunctionScript() {
    local file="${1}"
    reloadScript "${FUNCTIONS}" "${file}"
}

bashrc() {
    local arg="${1}"
    case "${arg}" in
        "edit" | "ide")
            local ide="${2}"
            IDE="${ide}" ide "${BASH_DIR}"
            ;;
        "cd" | "go")
            cd "${BASH_DIR}"
            ;;
        "func" | "functions")
            importAll functions
            ;;
        "config")
            importAll configs
            ;;
        "")
            importAll all
            ;;
        "sh")
            local file=$(fd --base-directory "${FUNCTIONS}" --type file --extension sh | skim)
            if [[ "${file}" == "" ]]; then
                return 1
            fi
            reloadFunctionScript "${file}"
            ;;
        "-h" | "-help" | "--help")
            echo >&2 "Usage: ${FUNCNAME[0]} [edit | code | cd | go | func | functions | config | <bash script in ${FUNCTIONS}>]"
            return 1
            ;;
        *.sh)
            reloadFunctionScript "${arg}"
            ;;
        *)
            local ide="${arg}"
            IDE="${ide}" ide "${BASH_DIR}"
            ;;
    esac
}

bashrc_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    compgen -W "edit ide cd go func functions config sh -h -help --help" -- "${arg}"
    compgen -W "$(ideList)" -- "${arg}"
    cd "${FUNCTIONS}" && compgen -f -X '!*.sh' -- "${arg}"
}

bashrc_complete() {
    compReply bashrc_compgen
}

rc() {
    bashrc "${@}"
}

export -f bashrc
export -f rc

complete -F bashrc_complete bashrc
inheritCompletion bashrc rc
