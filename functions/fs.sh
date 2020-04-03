fs() {
    local dir="${1-.}"
    local field="${2}"
    local fsRoot=$(df -T "${dir}" | sed -n '2p' | awk '{print $7}')
    local mountOptions=$(mount -l | rg " ${fsRoot} ")
    case "${field}" in
        name)
            local col=1
            ;;
        root)
            local col=3
            ;;
        type)
            local col=5
            ;;
        options)
            local col=6
            ;;
        all | "")
            echo "${mountOptions}"
            return
            ;;
        *)
            echo >&2 "Usage: ${FUNCNAME[0]} <dir> [name | root | type | options | all]"
            return 1
    esac
    echo "${mountOptions}" | awk "{print \$${col}}"
}

fs_compgen() {
    local i="${1}"
    local arg="${2}"
    case ${i} in
        1)
            compgen -W "." -- "${arg}"
            compgen -d -- "${arg}"
            ;;
        2)
            compgen -W "name root type options all" -- "${arg}"
            ;;
    esac
}

fs_complete() {
    compReply fs_compgen
}

complete -F fs_complete fs
