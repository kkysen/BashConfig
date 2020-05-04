generateXdgUserDirs() {
    local dirs=(DESKTOP DOWNLOAD TEMPLATES PUBLICSHARE DOCUMENTS MUSIC PICTURES VIDEOS)
    for dir in "${dirs[@]}"; do
        local name="XDG_${dir}_DIR"
        local value="${!name}"
        if [[ "${value}" != "" ]]; then
            echo "${name}=\"${value}\""
        fi
    done
}

saveXdgUserDirs() {
    generateXdgUserDirs > "${XDG_CONFIG_HOME}/user-dirs.dirs"
}

export -f saveXdgUserDirs
