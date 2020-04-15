pselect() {
    ps -e --format pid,ppid,pcpu,pmem,etime,user,comm,args |
        awk '$5 != "00:00"' |
        skim --tac --header-lines 1 |
        awk '{print $1}'
}

export -f pselect
