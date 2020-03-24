export WORKSPACE_BIN="${WORKSPACE}/bin"

export LOCAL_BIN="${HOME}/.local/bin"

# shellcheck disable=SC2230
export JAVA_HOME=$(readlink -m "$(which java)/../..")

export CARGO_BIN="${WORKSPACE}/Rust/.cargo/bin"
