# TODO change this to the Rust version
locate() {
    lolcate "${@}"
}

allUsing() {
    local dir="${DIR}"
    local skimCmd
    if [[ "${dir}" == "" ]]; then
        skimCmd="locate"
    else
        absDir=$(realpath "${dir}")
        skimCmd="locate | rg \"^${absDir}\""
    fi
    SKIM="${skimCmd}" ${CMD} "${@}"
}

skall() {
    CMD="sk" allUsing "${@}"
}

fall() {
    CMD="fo ." allUsing "${@}"
}

export -f locate
export -f skall
export -f fall
