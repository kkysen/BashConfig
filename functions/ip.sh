myip() {
    # much faster (3-5x) than `curl`ing a website
    # since this just does a DNS lookup
    dig @resolver1.opendns.com ANY myip.opendns.com +short
}

geoip() {
    local ip=${1}
    curl -s "https://ipapi.co/${ip}/json/"
    echo
}

export -f myip
export -f geoip
