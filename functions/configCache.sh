configCache() {
    local configName="${1}"
    local configScript="${CONFIG_DIR}/${configName}.sh"
    local configGenerated="${CONFIG_DIR}/${configName}.gen.sh"
    if [[ ! -f "${configGenerated}" ]]; then
        "${configScript}" > "${configGenerated}"
    fi
    . "${configGenerated}"
}

export -f configCache
