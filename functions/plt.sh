plt-clone() {
    local repoName="${1}"
    local gitHubUserName=$(git config --global user.username)
    clone "${repoName}-${gitHubUserName}" PLT4115-Fall2020
    mv "${repoName}-${gitHubUserName}" "${repoName}"
}

export -f plt-clone
