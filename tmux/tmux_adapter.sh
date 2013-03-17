#!/bin/bash

# hack to be able to use session environment variables
# in the tmux status bar (which executes in its own session)
#
# Usage: put _tmux_set_var_sync in $PS1 (e.g. in .bash_profile)
# Then use _tmux_get_var VAR in your tmux.config

_tmux_prefix() {
    local session_id=$(tmux display -p "#D" | tr -d %)
    local prefix="TMUX_VARS_${session_id}"
    echo "${prefix}"
}


_tmux_get_var() {
    # Usage: _tmux_get_var [VARNAME]
    # available vars: PWD, VENV
    #
    # requires _tmux_get_var_sync in $PS1

    local prefix=$(_tmux_prefix)
    local var_name=$1
    local env_name="${prefix}_${var_name}"
    local env_name_val=$(tmux show-environment "$env_name" 2>&1)

    if [[ ! $env_name_val =~ "unknown variable" ]]; then
        local env_val=$(echo "$env_name_val" | sed 's/^.*=//')
        echo "$env_val"
    fi
}


_tmux_set_var_sync() {
    if [ -z "$TMUX" ]
    then
        exit
    fi

    local prefix=$(_tmux_prefix)
    local pwd="$PWD"
    if [[ "$pwd" =~ ^"$HOME"(/|$) ]]
    then
        pwd="~${pwd#$HOME}"
    fi
    tmux setenv "${prefix}_pwd" "$pwd"

    if [ -n "$VIRTUAL_ENV" ]
    then
        tmux setenv "${prefix}_venv" "$(basename $VIRTUAL_ENV)"
    fi
}
