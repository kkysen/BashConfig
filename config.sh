. $CONFIG_DIR/sshd.sh
. $CONFIG_DIR/path.sh
. $CONFIG_DIR/aliases.sh
. $CONFIG_DIR/fnm.sh
. $CONFIG_DIR/ssh.sh
. $CONFIG_DIR/rustc.sh

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

. $CONFIG_DIR/history.sh
. $CONFIG_DIR/misc.sh
. $CONFIG_DIR/colors.sh
. $CONFIG_DIR/completion.sh
. $CONFIG_DIR/title.sh
. $CONFIG_DIR/perl.sh

. $CONFIG_DIR/broot.sh
. $CONFIG_DIR/brew.sh
