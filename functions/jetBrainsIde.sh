jetBrainsIdePaths() {
    local dir="${FUNCTIONS}/JetBrains"
    # shellcheck disable=SC2016
    rg \
        --no-filename \
        --no-line-number \
        -0 \
        'start "" (.*) %\*' \
        --replace '$1' \
        "${dir}" |
        sed 's/\r//' |
        map wslpath -u
}

jetBrainsIdePathToName() {
    map basename | sed 's/\([^64]*\)\(64\)\?.exe/\1/'
}

jetBrainsIdeNames() {
    jetBrainsIdePaths | jetBrainsIdePathToName
}

jetBrainsIdeSelect() {
    local ide="${1}"
    if [[ "${ide}" == "" ]]; then
        echo ""
        return
    fi
    local lowerIde="${ide,,}"
    declare -A nameToPath
    while read -r line; do
        local path="${line}"
        local name=$(echo "${path}" | jetBrainsIdePathToName)
        local lowerName="${name,,}"
        nameToPath[${lowerName}]="${path}"
    done < <(jetBrainsIdePaths)
    local path="${nameToPath["${lowerIde}"]}"
    echo "${path}"
}

jetBrainsIdeExact() {
    local ide="${1}"
    local path=$(jetBrainsIdeSelect "${ide}")
    if [[ "${path}" == "" ]]; then
        echo >&2 "Couldn't find any JetBrains IDEs matching \`${ide}\`"
        return 1
    fi
    guiAt "${path}" "${@:2}"
}

jetBrainsIde() {
    local ide="${1}"
    if [[ "${ide}" == "" ]]; then
        ide=$(jetBrainsIdeNames | skim)
        if [[ "${ide}" == "" ]]; then
            return 1
        fi
    fi
    if ! jetBrainsIdeExact "${ide}" "${@:2}"; then
        ide=$(jetBrainsIdeNames | skim)
        if [[ "${ide}" == "" ]]; then
            return 1
        fi
        jetBrainsIdeExact "${ide}" "${@:2}"
    fi
}

jetBrainsIdeByCaller() {
    jetBrainsIdeExact "${FUNCNAME[1]}" "${@}"
}

idea() {
    jetBrainsIdeByCaller "${@}"
}

clion() {
    jetBrainsIdeByCaller "${@}"
}

webStorm() {
    jetBrainsIdeByCaller "${@}"
}

pyCharm() {
    jetBrainsIdeByCaller "${@}"
}

rider() {
    jetBrainsIdeByCaller "${@}"
}

androidStudio() {
    jetBrainsIdeByCaller "${@}"
}

phpStorm() {
    jetBrainsIdeByCaller "${@}"
}

dataGrip() {
    jetBrainsIdeByCaller "${@}"
}

goLand() {
    jetBrainsIdeByCaller "${@}"
}

mps() {
    jetBrainsIdeByCaller "${@}"
}

rubyMine() {
    jetBrainsIdeByCaller "${@}"
}

appCode() {
    jetBrainsIdeByCaller "${@}"
}

export -f jetBrainsIdePaths
export -f jetBrainsIdeNames
export -f jetBrainsIde

export -f idea
export -f clion
export -f webStorm
export -f rider
export -f androidStudio
export -f phpStorm
export -f dataGrip
export -f goLand
export -f mps
export -f rubyMine
export -f appCode
