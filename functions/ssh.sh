droplet() {
    ssh root@206.189.226.167
}

clac() {
    ssh ks3343@clac.cs.columbia.edu
}

cunix() {
    ssh cunix
}

huxley() {
    # GPU compute cluster
    ssh huxley
}

rcs() {
    ssh rcs
}

export -f droplet
export -f clac
export -f cunix
export -f huxley
export -f rcs
