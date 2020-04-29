nodeDir() {
    dirname "$(rwhich node)"
}

export -f nodeDir

npmUsingNodeDir() {
    local nodeDir="${1}"
    "${nodeDir}/node" "${nodeDir}/npm" "${@:2}"
}

export -f npmUsingNodeDir

transferNpmPackage() {
    local oldNodeDir="${1}"
    local newNodeDir="${2}"
    local package="${3}"
    if npmUsingNodeDir "${newNodeDir}" install --global "${package}"; then
        npmUsingNodeDir "${oldNodeDir}" uninstall --global "${package}"
    fi
}

export -f transferNpmPackage

listNpmGlobalPackages() {
    local nodeDir_="${1}"
    if [[ "${nodeDir_}" == "" ]]; then
        nodeDir_=$(nodeDir)
    fi
    local globalPackagesDir="${nodeDir_}/../lib/node_modules"
    fd \
        --base-directory "${globalPackagesDir}" \
        --hidden \
        --no-ignore \
        --case-sensitive \
        --exact-depth 1 |
        rg --invert-match "^node|npm$"
}

export -f listNpmGlobalPackages

transferNpmPackages() {
    local oldNodeDir="${1}"
    local newNodeDir="${2}"
    listNpmGlobalPackages "${oldNodeDir}" |
        map transferNpmPackage "${oldNodeDir}" "${newNodeDir}"
}

export -f transferNpmPackages

transferNpmPackagesToVersion() {
    local version="${1}"
    local oldNodeDir=$(nodeDir)
    if ! fnm use "${version}"; then
        return 1
    fi
    local newNodeDir=$(nodeDir)
    transferNpmPackages "${oldNodeDir}" "${newNodeDir}"
}

export -f transferNpmPackagesToVersion
