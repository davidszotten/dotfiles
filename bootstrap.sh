#!/bin/bash

test -d ~/dotfiles || git clone https://github.com/davidszotten/dotfiles ~/dotfiles

mkdir -p ~/dotfiles/vim/pack/minpac/opt/
test -d ~/dotfiles/vim/pack/minpac/opt/minpac/ || git clone https://github.com/k-takata/minpac.git ~/dotfiles/vim/pack/minpac/opt/minpac

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
create_link "dotfiles/pdbrc.py"         ".pdbrc.py"
create_link "dotfiles/pystartup.py"     ".pystartup.py"
create_link "dotfiles/tmux/tmux.conf"   ".tmux.conf"
create_link "dotfiles/vim/"             ".vim"
create_link "dotfiles/vim/vimrc"        ".vimrc"
create_link "dotfiles/vim/gvimrc"       ".gvimrc"
create_link "dotfiles/karabiner"        ".config/karabiner"

popd >/dev/null
