PROMPT_DELIM="; "

prompt() {
    echo "${PROMPT_COMMAND}" | sd -s "${PROMPT_DELIM}" $'\n'
}

addPromptBefore() {
    prompt=("${@}")
    export PROMPT_COMMAND="${prompt[*]}; ${PROMPT_COMMAND}"
}

addPromptAfter() {
    prompt=("${@}")
    export PROMPT_COMMAND="${PROMPT_COMMAND}; ${prompt[*]}"
}

addPrompt() {
    addPromptAfter "${@}"
}

dedupePrompt() {
    dedupeVar PROMPT_COMMAND "${PROMPT_DELIM}" --no-trailing-delimiter
}

export -f addPromptBefore
export -f addPromptAfter
export -f addPrompt
export -f dedupePrompt
