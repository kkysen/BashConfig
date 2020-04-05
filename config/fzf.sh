# Setup fzf
# ---------
FZF_HOME="${HOMEBREW_PREFIX}/opt/fzf"
FZF_SHELL="${FZF_HOME}/shell"

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
    . "${FZF_SHELL}/completion.bash" 2>/dev/null
fi

# Key bindings
# ------------
#. "${FZF_SHELL}/key-bindings.bash"
