. "${FUNCTIONS}/cacheGenerated.sh"

cd "${CONFIGS}"

. timezone.sh
. path.sh
. xdg.sh
. sshd.sh
. aliases.sh
. fnm.sh
. ssh.sh
. rust.sh
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

. path.sh  # restore my own PATH order

cd ~-
