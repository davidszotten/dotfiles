
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


### aliases

alias ls='ls -G'
alias clean_pyc='find . -name "*.pyc" -delete'
alias figlet='figlet -f colossal -m 1'

# hack to set a default user. another -U overrides this
alias psql="psql -U postgres"

# force tmux to use 256 colours
alias tmux="tmux -2"


# local settings
local_bashrc="$HOME/.bash_profile.local"
if [ -e "$local_bashrc" ]
then
    source "$local_bashrc"
fi
