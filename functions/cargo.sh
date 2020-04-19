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
            --exact-depth 2 \
            --type directory \
            --fixed-strings \
            "${versionedCrate}"
    )
    # ideally, I could do an exact match with `fd`,
    # so just a stat() existence check could be used for the last level
    # instead of looping over readdir()
    local dir="${srcsDir}/${localDir}"
    echo "${dir}"
}

export -f cargoSrc
