cargoSrc() {
    if [ $# -lt 1 ]; then
        echo >&2 "Usage: ${FUNCNAME[0]} <crateName>"
        return 1
    fi
    local crateName="${1}"
    local version="${2}"
    if [[ "${version}" == "" ]]; then
        local versionedCrate=$(
            cargo install --list |
                rg "${crateName}" |
                sd --string-mode " v" "-" |
                sd ":$" ""
        )
    else
        local versionedCrate="${crateName}-${version}"
    fi
    local srcsDir="${CARGO_HOME}/registry/src"
    local localDir=$(
        fd \
            --no-ignore \
            --hidden \
            --case-sensitive \
            --base-directory "${srcsDir}" \
            --max-depth 2 \
            --type directory \
            --fixed-strings \
            "${versionedCrate}"
    )
    local dir="${srcsDir}/${localDir}"
    echo "${dir}"
}

export -f cargoSrc
