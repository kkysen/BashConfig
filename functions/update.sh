updateApt() {
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
}

export -f updateApt

updateBrew() {
    brew upgrade
}

export -f updateBrew

updateCargo() {
    cargo install-update --all
}

export -f updateCargo

updateCargo.exe() {
    win cargo install-update --all
}

export -f updateCargo.exe

updateRustup() {
    rustup update
}

export -f updateRustup

updateRustup.exe() {
    win rustup update
}

export -f updateRustup.exe

updateRust() {
    updateRustup
    updateCargo
}

export -f updateRust

updateRust.exe() {
    win updateRustup
    win updateCargo
}

updateLolcate() {
    lolcate --update --all
}

export -f updateLolcate

updateTmp() {
    cleanTmp
}

export -f updateTmp

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

export -f updatePip

updatePyenv() {
    pyenv update
}

export -f updatePyenv

updatePython() {
    updatePyenv
    updatePip
}

export -f updatePython

updateNpm() {
    npm update -g
}

export -f updateNpm

updateYarn() {
    (cd "${WIN_HOME}" && yarn global upgrade)
}

export -f updateYarn

updateNode() {
    fnm install latest
}

export -f updateNode

updateFnm() {
    curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh |
        bash -s -- --skip-shell
}

export -f updateFnm

updateJS() {
    updateFnm
    updateNode
    updateNpm
    updateYarn
}

export -f updateJS

updateNinja() {
    (cd "${WORKSPACE}/C++/ninja" && git pull && ninja)
}

export -f updateNinja

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

export -f updateCMake

updateStack() {
    stack upgrade
    stack update
}

export -f updateStack

updateStackPackages() {
    stack install pandoc
}

export -f updateStackPackages

updateHaskell() {
    updateStack
    updateStackPackages
}

export -f updateHaskell

update() {
    rc
    set -x
    updateApt
    updateBrew
    updateRust
    win updateRust
    updatePython
    updateJS
    updateHaskell
    updateTmp
    updateLolcate
    set +x
}

export -f update
