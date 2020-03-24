bottom() {
    # the WSL version crashes, so I'm using the Windows version
    "${WIN_HOME}/.cargo/bin/btm.exe" "${@}"
}

btm() {
    bottom "${@}"
}

export -f bottom
export -f btm
