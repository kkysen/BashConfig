selectLine() {
    if [[ ${#} -eq 0 ]]; then
        skim --tac --header-lines 1
    else
        rg "${@}"
    fi
}

pselect() {
    ps -e --format pid,ppid,pcpu,pmem,etime,user,comm,args |
        awk '$5 != "00:00"' |
        selectLine "${@}" |
        awk '{print $1}'
}

export -f pselect
