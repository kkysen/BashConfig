# shellcheck disable=SC1090
. "${CONFIG_DIR}"/programs.sh

export PATH=~/.local/bin:$FNM_BIN:$WORKSPACE_BIN:$CARGO_BIN:$NPM_GLOBAL_BIN:$CLANG_BIN:$EMSCRIPTEN_BIN:$LLVM_BIN:$MX_BIN:$CMAKE_BIN:$PATH:$NINJA_BIN:$PYPY_BIN:$PYPY3_BIN:$PYENV_BIN:$BINS
export PATH=$(printf "${PATH}" | huniq -d ":" | sed "s/:$//")

#. $EMSCRIPTEN_HOME/emsdk_set_env.sh
#. $MX_HOME/bash_completion/mx
