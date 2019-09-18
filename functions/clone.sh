clone() {
    if [[ "$#" -eq 0 ]]; then
        echo "Usage: clone [repoName] [userName = kkysen]"
        return 1
    fi

    local repoName=${1}
    local userName=${2}

    if [[ "$#" -eq 1 ]]; then
        userName=kkysen
    fi

	  git clone "git@github.com:${userName}/${repoName}.git"
}

export -f clone
