. "${FUNCTIONS}/configCache.sh"

cd "${CONFIG_DIR}"

. path.sh
. sshd.sh
. aliases.sh
. fnm.sh
. ssh.sh
. rustc.sh
. perl.sh
. broot.sh
configCache brew
. pkgConfig.sh
. pyenv.sh
configCache thefuck
. fzf.sh

cd ~-

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

cd "${CONFIG_DIR}"

. misc.sh
. colors.sh
. completion.sh
. title.sh

cd ~-
