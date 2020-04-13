selectAndKill() {
    ps -e --format pid,ppid,pcpu,pmem,etime,user,comm,args |
        awk '$5 != "00:00"' |
        skim --tac --header-lines 1 |
        awk '{print $1}' |
        xargs "kill"
}

kill() {
    if [[ $# -eq 0 ]]; then
        selectAndKill
    else
        command kill "${@}"
    fi
}

export -f kill
