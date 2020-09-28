onPath() {
    local skipPaths=""
    local filter=""
    local basenames=false
    local null=false
    local onlyExecutables=""
    local noSymlinks="--follow"
    local listDetails="-0"
    local extension=""

    while [[ $# -gt 0 ]]; do
        case "${1}" in
            --filenames)
                basenames=true
                ;;
            --skip-paths)
                skipPaths="${2}"
                shift
                ;;
            --skip-paths-default)
                skipPaths="WINDOWS|Program Files|mingw"
                ;;
            --filter)
                filter="${2}"
                shift
                ;;
            --null | -0)
                null=true
                ;;
            --executables)
                onlyExecutables="--type executable --type file"
                ;;
            --no-symlinks)
                noSymlinks=""
                ;;
            --list-details)
                listDetails="--list-details"
                ;;
            --extension)
                extension+=" --extension ${2}"
                shift
                ;;
        esac
        shift
    done

    local id=tee
    local pathFilter=("${id}")
    local exeFilter=("${id}")
    local basename=("${id}")
    local newlines=("${id}")

    if [[ "${skipPaths}" != "" ]]; then
        pathFilter=(rg --null-data --invert-match "${skipPaths}")
    fi
    if [[ "${filter}" != "" ]]; then
        # shellcheck disable=SC2206
        exeFilter=(rg --null-data ${filter[@]})
    fi
    if ${basenames}; then
        basename=(xargs --no-run-if-empty -0 basename --multiple --zero)
    fi
    if ! ${null}; then
        newlines=(tr '\0' '\n')
    fi

    # for more correctness, could use --follow --type executable for fd, but much slower b/c need to stat every file
    # shellcheck disable=SC2086
    printf "%s" "${PATH}" |
        tr ':' '\0' |
        "${pathFilter[@]}" |
        xargs --no-run-if-empty -0 \
            fd --hidden \
            --no-ignore \
            --case-sensitive \
            ${noSymlinks} \
            ${onlyExecutables} \
            ${extension} \
            --exact-depth 1 \
            ${listDetails} \
            . |
        "${exeFilter[@]}" |
        "${basename[@]}" |
        "${newlines[@]}"
}

export -f onPath

onPathBySize() {
    # this shellcheck that says du doesn't read from stdin is wrong
    # du can read from stdin w/ --files0-from -
    # shellcheck disable=SC2216
    onPath --executables -0 "${@}" |
        du --dereference --files0-from - --bytes --human-readable |
        sort -k1 --human-numeric-sort
}

export -f onPathBySize

onPathBySizeLinux() {
    onPathBySize --skip-paths-default --filter '-v \.(exe|dll)'
}

export -f onPathBySizeLinux
