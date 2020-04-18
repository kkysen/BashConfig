onPathMeta() {
    # It'd be much easier if I could have a no-op pipe.
    # `tee` and `cat` work for this, but they're slow.
    # Normally this is okay, but since this can be used for completion,
    # speed is important.
    # Ideally, bash would have a no-op pipe that just dup2()s stdin to stdout.
    # Thus, I have to generate the source code and `eval` it.
    # Sometimes this is faster, sometimes it's slower.

    local skip=""
    local basenames=false
    local null=false

    while [[ $# -gt 0 ]]; do
        case "${1}" in
            --filenames)
                basenames=true
                ;;
            --skip)
                skip="${2}"
                shift
                ;;
            --skip-default)
                skip="WINDOWS|Program Files|mingw"
                ;;
            --null | -0)
                null=true
                ;;
        esac
        shift
    done

    local xargs=" | xargs --no-run-if-empty -0"

    echo -n 'printf "%s" "${PATH}"'
    echo -n " | tr ':' '\0'"
    if [[ "${skip}" != "" ]]; then
        echo -n " | rg --null-data --invert-match '${skip}'"
    fi
    echo -n "${xargs}"
    echo -n " fd --hidden --no-ignore --case-sensitive --exact-depth 1"
    if ${basenames} || ${null}; then
        echo -n " -0"
    fi
    echo -n " ."
    if ${basenames}; then
        echo -n "${xargs}"
        echo -n " basename --multiple"
        if ${null}; then
            echo -n " --zero"
        fi
    fi
}

onPathEval() {
    eval "$(onPathMeta "${@}")"
}

onPath() {
    local skip=""
    local basenames=false
    local null=false

    while [[ $# -gt 0 ]]; do
        case "${1}" in
            --filenames)
                basenames=true
                ;;
            --skip)
                skip="${2}"
                shift
                ;;
            --skip-default)
                skip="WINDOWS|Program Files|mingw"
                ;;
            --null | -0)
                null=true
                ;;
        esac
        shift
    done

    local id=tee
    local filter=("${id}")
    local basename=("${id}")
    local newlines=("${id}")

    if [[ "${skip}" != "" ]]; then
        filter=(rg --null-data --invert-match "${skip}")
    fi
    if ${basenames}; then
        basename=(xargs --no-run-if-empty -0 basename --multiple --zero)
    fi
    if ! ${null}; then
        newlines=(tr '\0' '\n')
    fi

    # for more correctness, could use --follow --type executable for fd, but much slower b/c need to stat every file
    printf "%s" "${PATH}" |
        tr ':' '\0' |
        "${filter[@]}" |
        xargs --no-run-if-empty -0 \
            fd --hidden \
            --no-ignore \
            --case-sensitive \
            --exact-depth 1 \
            -0 . |
        "${basename[@]}" |
        "${newlines[@]}"
}

export -f onPath
