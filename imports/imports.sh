export PATH="${WORKSPACE}/bin:${PATH}" # fnm on path
. "${CONFIGS}/fnm.sh"                  # correct node version on path
. "${CONFIGS}/volta.sh"
. "${FUNCTIONS}/node.sh"               # node_mjs for import
. "${FUNCTIONS}/import.sh"             # import func
. "${FUNCTIONS}/imports.sh"            # importAll func
importAll
