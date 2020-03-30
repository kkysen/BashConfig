# TODO change this to the Rust version
locate() {
    lolcate "${@}"
}

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

skall() {
    locateInDir "${@}" | skim
}

fall() {
    local locateArgs=("${LOCATE_ARGS}")
    mapOpenWith "${@}" < <(skall "${locateArgs[@]}")
}

export -f locate
export -f locateInDir
export -f skall
export -f fall
