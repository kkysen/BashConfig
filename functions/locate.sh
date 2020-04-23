# TODO change this to the Rust version
locate() {
    lolcate "${@}"
}

export -f locate

locateInDir() {
    local dir="${DIR}"
    if [[ ! "${dir}" == "" ]]; then
        absDir=$(realpath -f "${dir}")
        local filter="rg \"^${absDir}\""
    else
        local filter=cat
    fi
    # lolcate panics when output pipe is closed before it's done writing to it
    locate "${@}" 2> /dev/null | "${filter}"
}

export -f locateInDir

skall() {
    locateInDir "${@}" | skim
}

export -f skall

fall() {
    local openArgs="${1}"
    local locateArgs="${2}"
    # shellcheck disable=SC2086
    mapOpenWith "" "${openArgs}" < <(skall ${locateArgs})
}

export -f fall

locate.exe() {
    # Everything program, much faster than lolcate and always up-to-date
    # can't integrate with skim as well though, but it has its own skim in a GUI
    if [[ $# -eq 0 ]]; then
        win everything
    else
        win es "${@}" | IFS=$'\r\n' map wslpath -u
    fi
}

export -f locate.exe
