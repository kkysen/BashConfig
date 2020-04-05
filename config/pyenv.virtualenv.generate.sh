if [[ -d "${PYENV_ROOT}" ]] && [[ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]]; then
    pyenv virtualenv-init -
fi
