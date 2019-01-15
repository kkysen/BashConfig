alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias lla="ls -al"
alias venv=". ~/venv/bin/activate"
alias venv3=". ~/venv3/bin/activate"
alias droplet="ssh root@206.189.226.167"
alias clac="ssh ks3343@clac.cs.columbia.edu"
alias cunix="ssh ks3343@cunix.columbia.edu"
alias valgrind="valgrind --leak-check=full --show-leak-kinds=all"

alias mmake="node $WORKSPACE/TS/mmake/src/ts/core/main.js"

alias makeCaseSensitive="copyReplace"