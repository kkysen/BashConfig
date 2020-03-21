cacheGenerated() {
    local generator="${1}"
    local generated="${2}"
    if [[ ! -f "${generated}" ]]; then
        "${generator}" > "${generated}"
    fi
}

genConfig() {
    local name="${1}"
    local dir="${CONFIGS}"
    local generator="${dir}/${name}.sh"
    local generated="${dir}/${name}.gen.sh"
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
