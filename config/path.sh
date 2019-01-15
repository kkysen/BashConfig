export WIN_HOME=/mnt/c/Users/Khyber
export WORKSPACE=$WIN_HOME/workspace

export PATH=$WORKSPACE/npm/global/bin:$PATH

source $WORKSPACE/C++/emsdk/emsdk_set_env.sh

export PATH=$WORKSPACE/C++/emsdk/emscripten/1.37.36:$PATH
export PATH=$WORKSPACE/C++/llvm/build/bin:$PATH

export PATH=$WORKSPACE/Java/graal/mx:$PATH
source $WORKSPACE/Java/graal/mx/bash_completion/mx

export JAVA_HOME=/usr/lib/jvm/java-10-oracle/

export PATH=$PATH:$WORKSPACE/C++/ninja
