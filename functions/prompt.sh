PROMPT_DELIM=";"

prompt() {
    echo "${PROMPT_COMMAND}" | sd -s "${PROMPT_DELIM}" $'\n'
}

addPromptBefore() {
    local prompt="${*}"
    if [[ "${PROMPT_COMMAND}" == "" ]]; then
        PROMPT_COMMAND="${prompt}"
    else
        PROMPT_COMMAND="${prompt}${PROMPT_DELIM}${PROMPT_COMMAND}"
    fi
    export PROMPT_COMMAND
}

addPromptAfter() {
    local prompt="${*}"
    if [[ "${PROMPT_COMMAND}" == "" ]]; then
        PROMPT_COMMAND="${prompt}"
    else
        PROMPT_COMMAND="${PROMPT_COMMAND}${PROMPT_DELIM}${prompt}"
    fi
    export PROMPT_COMMAND
}

addPrompt() {
    addPromptAfter "${@}"
}

dedupePrompt() {
    dedupeVar PROMPT_COMMAND "${PROMPT_DELIM}" --no-trailing-delimiter
    export PROMPT_COMMAND="$(
        printf "%s" "${PROMPT_COMMAND}" |
            sd --string-mode ";;" ";" |
            sd "^;" ""
    )"
}

export -f addPromptBefore
export -f addPromptAfter
export -f addPrompt
export -f dedupePrompt
