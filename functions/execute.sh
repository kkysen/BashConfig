toWinPath() {
    local path="${1}"
    if [[ ! "${path}" == *"/"* ]]; then
        echo "${path}"
        return
    fi
    local dir=$(dirname -- "${path}")
    if [[ -d "${dir}" ]]; then
        wslpath -w "${path}"
    else
        echo "${path}"
    fi
}

execute() {
    # first arg is the executable
    # if the executable is an ELF binary for Linux, don't do anything
    # if the executable is a shell script, don't do anything
    # if the executable is a PE32 or PE32+ binary for Windows,
    # then for each argument, we try to convert posix paths to windows path using wslpath
    # for each argument, if it is an existing file, convert it
    # if it's not an existing file but still looks like a file path, try to convert it
    # if the directories in the path exist, convert the path then

    local executable="${1}"
    local args=("${@:2}")

    if isWindowsExe "${executable}"; then
        for i in "${!args[@]}"; do
            args[i]=$(toWinPath "${args[i]}")
        done
    fi

    "${executable}" "${args[@]}"
}

exe() {
    execute "${@}"
}

run() {
    execute "${@}"
}

export -f toWinPath

export -f execute
export -f exe
export -f run
