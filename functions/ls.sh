export LS="exa"

function ls() {
    ${LS} "${@}"
}

ll() {
    ${LS} -alF "${@}"
}

la() {
    ${LS} -A "${@}"
}

l() {
    ${LS} -CF "${@}"
}

llc() {
    ll --sort changed
}

export -f ls
export -f ll
export -f la
export -f l
export -f llc
