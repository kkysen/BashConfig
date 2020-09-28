# wrappers around wsl.exe that use the current distro
wsl() {
    local self="${WSL_DISTRO_NAME}"
    local cmd="${1}"
    case "${cmd}" in
        --help)
            win wsl --help
            ;;
        export|setdefault|terminate|unregister|upgrade)
            win wsl "--${cmd}" "${self}" "${@:2}"
            ;;
        *)
            echo >&2 "'${cmd}' is not a valid wsl command for the current distro"
            return 1
            ;;
    esac
}

export -f wsl

wsl_compgen() {
    local i="${1}"
    local arg="${2}"
    if [[ ${i} -ne 1 ]]; then
        return
    fi
    compgen -W "export setdefault terminate unregister upgrade" -- "${arg}"
}

wsl_complete() {
    compReply wsl_compgen
}

complete -F wsl_complete wsl
