cacheGenerated() {
    local generator="${1}"
    local generated="${2}"
    if [[ ! -f "${generated}" ]]; then
        "${generator}" > "${generated}"
    fi
}

genConfig() {
    local name="${1}"
    local dir="${2}"
    local generator="${dir}/${name}.generate.sh"
    local generated="${dir}/${name}.generated.sh"
    cacheGenerated "${generator}" "${generated}"
    . "${generated}"
}

genCompletion() {
    local name="${1}"
    local generator="${GEN_COMPLETIONS}/${name}.sh"
    local generated="${COMPLETIONS}/${name}"
    cacheGenerated "${generator}" "${generated}"
}

export -f cacheGenerated
export -f genConfig
export -f genCompletion
