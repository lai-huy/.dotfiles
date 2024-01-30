#!/bin/bash

declare -A files=(
    [~/.dotfiles/bash/.bashrc]="$HOME/.bashrc"
    [~/.dotfiles/bash/.bash_profile]="$HOME/.bash_profile"
    [~/.dotfiles/bash/.bash_logout]="$HOME/.bash_logout"
    [~/.dotfiles/git/.gitconfig]="$HOME/.gitconfig"
    [~/.dotfiles/vim/.vimrc]="$HOME/.vimrc"
    # Add more files in the same manner if needed
)

for source_file in "${!files[@]}"; do
    target_file="${files[$source_file]}"

    if [ ! -L "$target_file" ]; then
        ln -s $source_file $target_file
    else
        echo "$target_file already exists."
    fi
done

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

exec bash

