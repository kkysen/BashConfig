installPython() {
    local major=${1}
    local minor=${2}
    local patch=${3}
    local version="${major}.${minor}.${patch}"
    cd "${WORKSPACE}/Python/PythonSource"
    wget "https://www.python.org/ftp/python/${version}/Python-${version}.tgz"
    tar xzf "Python-${version}.tgz"
    cd "Python-${version}"
    ./configure --enable-optimizations
    make -j8
    sudo make altinstall
    local priority=$(($(update-alternatives --list python | wc -l) + 1))
    local py="python${major}.${minor}"
    sudo update-alternatives --install /usr/bin/python python "/usr/local/bin/${py}" ${priority}
    "${py}" -m pip install --upgrade pip --user
}

export -f installPython
