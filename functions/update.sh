updateApt() {
    sudo apt update
    sudo apt upgrade
}

updateBrew() {
    brew upgrade
}

updateCargo() {
    cargo install-update --all
}

updateRustup() {
    rustup update
}

updateRust() {
    updateRustup
    updateCargo
}

updateLolcate() {
    lolcate --update --all
}

updateTmp() {
    cleanTmp
}

pipUpdateRequirements() {
    python -m pip freeze |
        sd --string-mode "==" ">="
}

updatePip() {
    local version=$(pyenv global)
    pyenv global 3.8.2
    python -m pip install --upgrade -r <(pipUpdateRequirements)
    pyenv global "${version}"
}

updatePyenv() {
    pyenv update
}

updatePython() {
    updatePyenv
    updatePip
}

updateNpm() {
    npm update -g
}

updateYarn() {
    yarn global upgrade
}

updateNode() {
    fnm install latest
}

updateFnm() {
    curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh |
        bash -s -- --skip-shell
}

updateJS() {
    updateFnm
    updateNode
    updateNpm
    updateYarn
}

updateNinja() {
    (cd "${WORKSPACE}/C++/ninja" && git pull && ninja)
}

updateCMake() {
    local user="Kitware"
    local repo="CMake"
    local cmakeDir="${WORKSPACE}/C++/cmake"
    local releases="${user}/${repo}/releases"
    local apiUrl="https://api.github.com/repos/${releases}/latest"
    local jsFunc='e => (/v?([0-9]+\.[0-9]+\.[0-9]+)/.exec(e.tag_name) || ["", ""])[1]'
    local version=$(curl --silent "${apiUrl}" | js "${jsFunc}")
    if [[ "${version}" == "" ]]; then
        return 1
    fi

    local current="${cmakeDir}/current"
    local currentDir=$(readlink "${current}")
    local dir="cmake-${version}-Linux-x86_64"
    if [[ "${dir}" == "${currentDir}" ]] && [[ -d "${cmakeDir}/${dir}" ]]; then
        return
    fi

    local fileName="${dir}.sh"
    local installerPath="${cmakeDir}/${fileName}"
    if [[ ! -f "${installerPath}" ]]; then
        local downloadUrl="https://github.com/${releases}/download/v${version}/${fileName}"
        curl --location --output "${installerPath}" "${downloadUrl}"
    fi
    if ! (cd "${cmakeDir}" && "${installerPath}") < <(echo yy) >/dev/null; then
        return 1
    fi

    rm "${current}"
    ln -s "${dir}" "${current}"
}

update() {
    rc
    set -x
    updateApt
    updateBrew
    updateRust
    updatePython
    updateJS
    updateTmp
    updateLolcate
    set +x
}

export -f updateApt
export -f updateBrew
export -f updateCargo
export -f updateRustup
export -f updateRust
export -f updateLolcate
export -f updateTmp
export -f updatePip
export -f updatePyenv
export -f updatePython
export -f updateNpm
export -f updateYarn
export -f updateNode
export -f updateFnm
export -f updateJS
export -f updateNinja
export -f updateCMake

export -f update
