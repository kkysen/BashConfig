SKIM_HOME="$(cargoSrc skim "$(sk --version)")"
SKIM_SHELL="${SKIM_HOME}/shell"

if [[ $- == *i* ]]; then
    . "${SKIM_SHELL}/completion.bash" 2>/dev/null
    . "${SKIM_SHELL}/key-bindings.bash"
fi
