PERL5="/home/kkysen/perl5"

export PATH="${PERL5}/bin${PATH:+:${PATH}}"
export PERL5LIB="${PERL5}/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="${PERL5}${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"${PERL5}\""
export PERL_MM_OPT="INSTALL_BASE=${PERL5}"
