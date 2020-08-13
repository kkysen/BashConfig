# usually I would genConfig this, but Rust executables run much faster
#eval "$(starship init bash)"

starship_preexec() {
    local PREV_LAST_ARG=$1

    if [ "$PREEXEC_READY" = "true" ]; then
        PREEXEC_READY=false
        STARSHIP_START_TIME=$("/mnt/c/Users/Khyber/workspace/Rust/.cargo/bin/starship" time)
    fi

    : "$PREV_LAST_ARG"
}

starship_precmd() {
    STATUS=$?

    "${starship_precmd_user_func-:}"

    eval "$_PRESERVED_PROMPT_COMMAND"

    if [[ $STARSHIP_START_TIME ]]; then
        STARSHIP_END_TIME=$("/mnt/c/Users/Khyber/workspace/Rust/.cargo/bin/starship" time)
        STARSHIP_DURATION=$((STARSHIP_END_TIME - STARSHIP_START_TIME))
        PS1="$("/mnt/c/Users/Khyber/workspace/Rust/.cargo/bin/starship" prompt --status=$STATUS --jobs="$(jobs -p | wc -l)" --cmd-duration=$STARSHIP_DURATION)"
        unset STARSHIP_START_TIME
    else
        PS1="$("/mnt/c/Users/Khyber/workspace/Rust/.cargo/bin/starship" prompt --status=$STATUS --jobs="$(jobs -p | wc -l)")"
    fi
    PREEXEC_READY=true  # Signal that we can safely restart the timer
}

if [[ $preexec_functions ]]; then
    preexec_functions+=('starship_preexec "$_"')
    precmd_functions+=(starship_precmd)
else
    dbg_trap="$(trap -p DEBUG | cut -d' ' -f3 | tr -d \')"
    if [[ -z "$dbg_trap" ]]; then
        trap 'starship_preexec "$_"' DEBUG
    elif [[ "$dbg_trap" != 'starship_preexec "$_"' && "$dbg_trap" != 'starship_preexec_all "$_"' ]]; then
        starship_preexec_all() {
            local PREV_LAST_ARG=$1 ; $dbg_trap; starship_preexec; : "$PREV_LAST_ARG";
        }
        trap 'starship_preexec_all "$_"' DEBUG
    fi

    if [[ -z "$PROMPT_COMMAND" ]]; then
        PROMPT_COMMAND="starship_precmd"
    # TODO FIXME lack of trailing * is the bug here
    elif [[ "$PROMPT_COMMAND" != *"starship_precmd"* ]]; then
        _PRESERVED_PROMPT_COMMAND="$PROMPT_COMMAND"
        PROMPT_COMMAND="starship_precmd"
    fi
fi

STARSHIP_START_TIME=$("/mnt/c/Users/Khyber/workspace/Rust/.cargo/bin/starship" time)
export STARSHIP_SHELL="bash"

export STARSHIP_CONFIG="${CONFIG_DIR}/starship/starship.toml"
