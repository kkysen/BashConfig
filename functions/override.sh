override() {
    # overrides a function by renaming it to _${original_function_name}
    local funcName="${1}"
    eval "$(declare -f "${funcName}" | sed '1s/.*/_&/')"
}
