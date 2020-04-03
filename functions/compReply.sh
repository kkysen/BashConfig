compReply() {
    local compgenCommand="${1}"
    mapfile -t -O "${#COMPREPLY[@]}" COMPREPLY \
        < <("${compgenCommand}" "${COMP_CWORD}" "${COMP_WORDS[${COMP_CWORD}]}")
}

export -f compReply
