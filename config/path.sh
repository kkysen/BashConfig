# shellcheck disable=SC1090
. "${CONFIGS}/programs.sh"

export PATH="${WORKSPACE_BIN}:${CARGO_BIN}:${LOCAL_BIN}:${PATH}"
dedupePath
