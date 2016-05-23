
# prevent accidantally closing shells
# ignores n consecutive EOF
export IGNOREEOF=2

### bash history

# Erase duplicates
export HISTCONTROL=erasedups
# resize history size
export HISTSIZE=5000
# append to bash_history if Terminal.app quits
shopt -s histappend

# i never freeze my terminal, but i would like forward search
stty stop 'undef'

# C-x C-e drops into $EDITOR to edit the current command before executing
export EDITOR=vim

# for python readline support
export PYTHONSTARTUP=~/.pystartup.py

export GREP_OPTIONS='--color=auto'


### aliases

alias ls='ls -G'
alias clean_pyc='find . -name "*.pyc" -delete'
alias figlet='figlet -f colossal -m 1'
alias conflictack='ack "^(<|>|=){7}($| )"'

# git_open_conflicts git ls-files -m|sort -u|xargs mvim

# hack to set a default user. another -U overrides this
alias psql="psql -U postgres"

# force tmux to use 256 colours
alias tmux="tmux -2"


# homebrew where available
if [[ $(which brew) ]]
then
    BREW=$
    PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH

    if [ -f $(brew --prefix)/etc/bash_completion ]
    then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

PATH=$PATH:$HOME/dotfiles/bin:$HOME/bin:$HOME/.local/bin


_jobs_running() {
    local jobs_running=$(jobs -rp| wc -l| tr -d ' ')
    local jobs_stopped=$(jobs -sp| wc -l| tr -d ' ')
    local total_jobs=$(($jobs_running + $jobs_stopped))
    if [[ "$total_jobs" != "0" ]]
    then
        echo "($total_jobs)"
    fi
}


function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    # prompt
    GRAY="\[\033[0;30m\]"
    PINK="\[\033[0;35m\]"
    GREEN="\[\033[0;32m\]"
    BLUE="\[\033[0;34m\]"
    RESET="\[\033[0m\]"
    ITERM_TAB_RESET="\[\033]0;\007\]"

    GIT_PS1_SHOWDIRTYSTATE=1

    if [ -n "$VIRTUAL_ENV" ]
    then
        VIRTUAL_ENV_NAME=$(basename "$VIRTUAL_ENV")
        PS1+="($VIRTUAL_ENV_NAME)"
    fi

    PS1+="$GRAY\u@\h:${PINK}\W"
    PS1+="$GREEN\$(type -t __git_ps1 > /dev/null && __git_ps1 \" (%s)\")"
    PS1+="$BLUE\$(_jobs_running)"

    if [ $EXIT != 0 ]
    then
        PS1+="$PINK\$ $RESET"      # Add red if exit code non 0
    else
        PS1+="$RESET\$ "
    fi

    PS1+="$ITERM_TAB_RESET"
}

export PROMPT_COMMAND=__prompt_command


export PIP_REQUIRE_VIRTUALENV=true
syspip() {
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}


# complete for hub pull-request
_hub_complete() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "pull-request" -- $cur) )
}
complete -F _hub_complete hub


# local settings
local_bashrc="$HOME/.bash_profile.local"
if [ -e "$local_bashrc" ]
then
    source "$local_bashrc"
fi
