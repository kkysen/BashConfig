rclone.exe() {
    local configFile=$(rclone config file | sed -n "2p")
    local winConfigFile=$(wslpath -w "${configFile}")
    command rclone.exe --config "${winConfigFile}" "${@}"
}

export -f rclone.exe
