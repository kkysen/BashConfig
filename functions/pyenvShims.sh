createFastPyEnvShims() {
    # pyenv shims are very slow b/c they go through pyenv, which is slow (.3-1 sec)
    # my pyenv-python crate (exe python) is much faster (.03 sec)
    # symlink python to shims,
    # put them in $PYENV_ROOT/fast-shims,
    # and add them to $PATH instead of $PYENV_ROOT/shims
    local originalShimDir="${1}"
    if [[ "${originalShimDir}" == "" ]]; then
        fd \
            -uu \
            --exclude versions \
            --type directory \
            --search-path "${PYENV_ROOT}" \
            '^shims$' |
            map createFastPyEnvShims
        return
    fi
    local dir="$(dirname "${originalShimDir}")/fast-shims"
    rm -rf "${dir}"
    mkdir "${dir}"
    # shellcheck disable=SC2230
    local python=$(which python)

    fd \
        -uu \
        --exact-depth 1 \
        --search-path "${originalShimDir}" \
        . \
        --exec \
        ln --symbolic "${python}" "${dir}/{/}"
}

export -f createFastPyEnvShims
