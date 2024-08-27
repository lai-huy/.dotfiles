#!/bin/bash
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for sudo permission
echo "Do you want to run this script with sudo privileges for installing packages? (yes/no)"
read -r sudo_perms

if [ "$sudo_perms" == "yes" ]; then
    sudo -v

    if ! command_exists git; then
        sudo apt install -y git
    fi

    if ! command_exists curl; then
        sudo apt install -y curl
    fi

    if ! command_exists g++; then
        sudo apt install g++;
    fi

    if ! command_exists gcc; then
        sudo apt install gcc;
    fi

    if ! command_exists gdb; then
        sudo apt install gdb;
    fi
else
    echo "Skipping package installation and proceeding with symbolic linking."
fi

# Symbolically link some config files
declare -A files=(
    ["$HOME/.dotfiles/bash/.bashrc"]="$HOME/.bashrc"
    ["$HOME/.dotfiles/bash/.bash_aliases"]="$HOME/.bash_aliases"
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

# Install brew stuff
if ! command_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
    
    if ! command_exists gh; then
        brew install gh
    fi

    if ! command_exists nvim; then
        brew install neovim
    fi

    if ! command_exists oh-my-posh; then
        brew install oh-my-posh
    fi

    if ! command_exists lsd; then
        brew install lsd
    fi

    if ! command_exists diff-so-fancy; then
        brew install diff-so-fancy
    fi
fi

