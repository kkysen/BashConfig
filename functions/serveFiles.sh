serveFiles() {
    python3 -m http.server "${@}"
}

export -f serveFiles
