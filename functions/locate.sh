# TODO change this to the Rust version
locate() {
    lolcate "${@}"
}

skall() {
    SKIM_DEFAULT_COMMAND="lolcate" sk "${@}"
}

fall() {
    SKIM_DEFAULT_COMMAND="lolcate" fo . "${@}"
}

export -f locate
export -f skall
export -f fall
