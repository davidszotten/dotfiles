#!/bin/bash

test -d ~/dotfiles || git clone https://github.com/davidszotten/dotfiles ~/dotfiles

pushd ~/dotfiles
git submodule init
git submodule update

function create_link {
    # move any existing files (but overwrite existing symlinks)

    TIMESTAMP=$(date +'%Y-%m-%d_%H:%M:%S')
    src=$1
    target=$2

    if [[ -e "$HOME/$target" && ! -h "$HOME/$target" ]]
    then
        mv "$HOME/$target" "$HOME/$target$TIMESTAMP"
    fi

    ln -sf "$HOME/$1" "$HOME/$2"
}

create_link "dotfiles/ackrc"            ".ackrc"
create_link "dotfiles/gitconfig"        ".gitconfig"
create_link "dotfiles/gitignore"        ".gitignore"
create_link "dotfiles/vim"              ".vim"
create_link "dotfiles/vim/vimrc"        ".vimrc"
create_link "dotfiles/vim/gvimrc"       ".gvimrc"
create_link "dotfiles/vim/bash_profile" ".bash_profile"
popd

# build c extension for command-t if possible
pushd ~/dotfiles/vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd
