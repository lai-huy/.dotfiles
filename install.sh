#!/bin/bash

declare -A files=(
    ["~/.dotfiles/.bashrc"]="$HOME/.bashrc"
    ["~/.dotfiles/git/.gitconfig"]="$HOME/.gitconfig"
    ["~/.dotfiles/vim/.vimrc"]="$HOME/.vimrc"
    # Add more files in the same manner if needed
)

for source_file in "${!files[@]}"; do
    target_file="${files[$source_file]}"

    if [ ! -L "$target_file" ]; then
        ln -s "$source_file" "$target_file"
    fi
done

source ~/.bashrc

