export _ZO_DATA="${BASH_DIR}/zoxide.db"

z() {
    if [[ $# -eq 0 ]]; then
        return
    fi
    result=$(zoxide query "${@}")
    case "${result}" in
        "query: "*)
            cd "${result#"query: "}"
            ;;
        *)
            echo "${result}"
            ;;
    esac
}

zi() {
    z -i
}

za() {
    zoxide add
}

zq() {
    zoxide query
}

zr() {
    zoxide remove
}

addPromptAfter za

export -f z
export -f za
export -f zq
export -f zr
