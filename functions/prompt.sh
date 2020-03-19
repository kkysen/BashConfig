if [[ "${PROMPT_COMMAND}" == "" ]]; then
    export PROMPT_COMMAND="true"  # so I can just add ; and a new command
fi

prompt() {
    echo "${PROMPT_COMMAND}" | sed "s/\; /\n/g"
}

addPromptBefore() {
    prompt="${@}"
    export PROMPT_COMMAND="${prompt}; ${PROMPT_COMMAND}"
}

addPromptAfter() {
    prompt="${@}"
    export PROMPT_COMMAND="${PROMPT_COMMAND}; ${prompt}"
}

addPrompt() {
    addPromptAfter "${@}"
}

export -f addPromptBefore
export -f addPromptAfter
export -f addPrompt
