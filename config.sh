. "${FUNCTIONS}/cacheGenerated.sh"

cd "${CONFIGS}"

. path.sh
. xdg.sh
. sshd.sh
. aliases.sh
. fnm.sh
. ssh.sh
. rustc.sh
. perl.sh
. broot.sh
genConfig brew
. pkgConfig.sh
. pyenv.sh
genConfig thefuck
. fzf.sh

cd ~-

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

cd "${CONFIGS}"

. misc.sh
. colors.sh
. completion.sh
. title.sh

cd ~-
