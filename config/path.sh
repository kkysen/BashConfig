# shellcheck disable=SC1090
. "${CONFIGS}/programs.sh"

export PATH="${WORKSPACE_BIN}:${CARGO_BIN}:${LOCAL_BIN}:${PATH}"
export PATH=$(printf "%s" "${PATH}" | huniq -d ":" | sed "s/:$//")
