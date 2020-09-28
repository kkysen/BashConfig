if [[ -d "${PYENV_ROOT}" ]]; then
    pyenv init - | rg --passthru '(shims)' --replace 'fast-shims'
fi
