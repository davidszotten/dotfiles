
### bash history

# Erase duplicates
export HISTCONTROL=erasedups
# resize history size
export HISTSIZE=5000
# append to bash_history if Terminal.app quits
shopt -s histappend


### aliases

alias ls='ls -G'

# hack to set a default user. another -U overrides this
alias psql="psql -U postgres"


# local settings
source .bash_profile.local
