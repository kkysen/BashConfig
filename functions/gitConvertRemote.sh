gitConvertRemote() {
    local protocol="${1}"
    local currentUrl="$(git remote get-url origin)"
    if newUrl="$(node ${FUNCTIONS}/gitConvertRemote.js ${protocol} ${currentUrl})"; then
        git remote set-url origin ${newUrl}
    fi
}

export -f gitConvertRemote
