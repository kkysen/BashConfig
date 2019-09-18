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
alias cunix="ssh cunix"
alias huxley="ssh huxley" # GPU compute cluster
alias rcs="ssh rcs"

alias rust="ssh adrianmorriso@dyn-129-236-230-187.dyn.columbia.edu" # Columbia University Wi-Fi
# 62, 187, keeps changing
alias unruly="ssh emmettwhitlock@dyn-160-39-237-53.dyn.columbia.edu"

alias valgrind="valgrind --leak-check=full --show-leak-kinds=all"

# shellcheck disable=SC2139
alias mmake="node ${WORKSPACE}/TS/mmake/src/ts/core/main.js"

alias makeCaseSensitive="copyReplace"

alias serveFiles="python3 -m http.server"

alias sagi="sudo apt install"

alias locate="locate -d ~/mnt.c.Users.db -d ~/mnt.c.Program\ Files.db -d ~/mnt.c.Program\ Files\ \(x86\).db -d /var/lib/mlocate/mlocate.db"
