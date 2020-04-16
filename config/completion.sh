# bash looks under ${BASH_COMPLETION_USER_DIR}/completions
export BASH_COMPLETION_USER_DIR=$(dirname "${COMPLETIONS}")

# From default .bashrc

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

genCompletion rustup
genCompletion cargo
genCompletion rclone
