#!/bin/bash

test -d ~/dotfiles || git clone --recursive https://github.com/davidszotten/dotfiles ~/dotfiles

pushd ~/dotfiles >/dev/null

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
create_link "dotfiles/hgrc"             ".hgrc"
create_link "dotfiles/inputrc"          ".inputrc"
create_link "dotfiles/pdbrc"            ".pdbrc"
create_link "dotfiles/pystartup.py"     ".pystartup.py"
create_link "dotfiles/tmux/tmux.conf"   ".tmux.conf"
create_link "dotfiles/vim/"             ".vim"
create_link "dotfiles/vim/vimrc"        ".vimrc"
create_link "dotfiles/vim/gvimrc"       ".gvimrc"
create_link "dotfiles/karabiner"        ".config/karabiner"

popd >/dev/null
