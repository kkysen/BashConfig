myip() {
    curl -s "https://api6.ipify.org"
    echo
}

geoip() {
    local ip=${1}
    curl -s "https://ipapi.co/${ip}/json/"
    echo
}

export -f myip
export -f geoip
