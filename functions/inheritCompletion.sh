inheritCompletion() {
    # only works for eagerly loaded completion functions right now
    local completedCommand="${1}"
    local toCompleteCommand="${2}"
    local completionCommand=$(complete -p ${completedCommand})
    if [[ "${completionCommand}" == "" ]]; then
        return 1
    fi
    local inheritedCompletionCommand="${completionCommand% *} ${toCompleteCommand}"
    ${inheritedCompletionCommand}
}

export -f inheritCompletion
