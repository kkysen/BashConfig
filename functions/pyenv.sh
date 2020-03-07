activate() {
    pyenv activate
}

deactivate() {
    pyenv deactivate
}

act() {
    activate
}

deact() {
    deactivate
}

export -f activate
export -f deactivate
export -f act
export -f deact
