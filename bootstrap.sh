#!/bin/bash

test -d ~/dotfiles || git clone https://github.com/davidszotten/dotfiles ~/dotfiles

pushd ~/dotfiles >/dev/null

# update submodules in parallel
submodules=$(git submodule status)
n_submodules=$(echo "$submodules"| wc -l)
echo "$submodules" \
  | awk '{print $2}' \
  | xargs -P$n_submodules -n1 git submodule update --init

function create_link {
    # move any existing files (but overwrite existing symlinks)

    TIMESTAMP=$(date +'%Y-%m-%d_%H:%M:%S')
    src=$1
    target=$2

    if [[ -e "$HOME/$target" && ! -h "$HOME/$target" ]]
    then
        mv "$HOME/$target" "$HOME/$target$TIMESTAMP"
    fi

    ln -sf "$HOME/$src" "$HOME/$target"
}

create_link "dotfiles/ackrc"            ".ackrc"
create_link "dotfiles/bash_profile"     ".bash_profile"
create_link "dotfiles/gitconfig"        ".gitconfig"
create_link "dotfiles/gitignore"        ".gitignore"
create_link "dotfiles/inputrc"          ".inputrc"
create_link "dotfiles/pystartup.py"     ".pystartup.py"
create_link "dotfiles/tmux/tmux.conf"   ".tmux.conf"
create_link "dotfiles/vim/"             ".vim"
create_link "dotfiles/vim/vimrc"        ".vimrc"
create_link "dotfiles/vim/gvimrc"       ".gvimrc"

popd >/dev/null
