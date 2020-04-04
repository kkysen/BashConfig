# Setup fzf
# ---------
FZF_HOME="${HOMEBREW_PREFIX}/opt/fzf"
FZF_BIN="${FZF_HOME}/bin"
FZF_SHELL="${FZF_HOME}/shell"

if [[ ! "${PATH}" == *"${FZF_BIN}"* ]]; then
    export PATH="${PATH}:${FZF_BIN}"
fi

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
    . "${FZF_SHELL}/completion.bash" 2>/dev/null
fi

# Key bindings
# ------------
. "${FZF_SHELL}/key-bindings.bash"
