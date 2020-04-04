# shellcheck disable=SC1090
. "${CONFIGS}/programs.sh"

setPath() {
    export PATH="${WORKSPACE_BIN}:${CARGO_BIN}:${LOCAL_BIN}:${PATH}"
}

export -f setPath

setPath
dedupePath
