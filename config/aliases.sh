
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

alias makeCaseSensitive="copyReplace"

alias serveFiles="python3 -m http.server"

alias sagi="sudo apt install"

alias locate="locate -d ~/mnt.c.Users.db -d ~/mnt.c.Program\ Files.db -d ~/mnt.c.Program\ Files\ \(x86\).db -d /var/lib/mlocate/mlocate.db"

alias open="open_"

alias wl="mklink"
alias lw="mklink"
alias lns="mklink"

alias LF="endlines unix -r"

alias node-mjs="node --no-warnings --experimental-modules"

alias js="node-mjs ${FUNCTIONS}/js.mjs"

alias arbtt="arbtt-stats --logfile=${APP_DATA}/Roaming/arbtt/capture.log --categorizefile=${APP_DATA}/Roaming/arbtt/categorize.cfg"

alias yt2mp3="youtube-dl --extract-audio --audio-format mp3 -o '${ONE_MUSIC}/%(title)s.%(ext)s'"
alias music="fopen ${ONE_MUSIC}"
