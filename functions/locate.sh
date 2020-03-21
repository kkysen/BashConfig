# TODO change this to the Rust version
locate() {
    lolcate "${@}"
}

allUsing() {
    local dir="${DIR}"
    local skimCmd="locate"
    if [[ ! "${dir}" == "" ]]; then
        absDir=$(realpath "${dir}")
        skimCmd="${skimCmd} | rg \"^${absDir}\""
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
