#!/bin/bash

declare -A files=(
    ["$HOME/.dotfiles/bash/.bashrc"]="$HOME/.bashrc"
    ["$HOME/.dotfiles/bash/.bash_profile"]="$HOME/.bash_profile"
    ["$HOME/.dotfiles/bash/.bash_logout"]="$HOME/.bash_logout"
    ["$HOME/.dotfiles/git/.gitconfig"]="$HOME/.gitconfig"
    ["$HOME/.dotfiles/vim/.vimrc"]="$HOME/.vimrc"
    # Add more files in the same manner if needed
)

for source_file in "${!files[@]}"; do
    target_file="${files[$source_file]}"

    if [ ! -L "$target_file" ]; then
        ln -s $source_file $target_file
    else
        rm -rf $target_file
        ln -s $source_file $target_file
    fi
done

curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

