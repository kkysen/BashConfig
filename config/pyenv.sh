if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    if [[ -d "$(pyenv root)/pyenv-virtualenv" ]]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi
