stripDir() {
    local dir="${1}"
    for binary in "${dir}"/*; do
        strip -s "${binary}"
    done
}

stripRust() {
    stripDir "${CARGO_BIN}"
    # strip doesn't work on Windows binaries (it doesn't fail either, though)
    # stripDir "${WIN_HOME}/.cargo/bin"
}

export -f stripRust
