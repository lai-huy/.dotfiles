#!/bin/bash
set -e  # Exit on error

# Colors for better output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status messages
status() {
    echo -e "${GREEN}[*]${NC} $1"
}

# Function to print warnings
warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check for sudo permission
read -r -p "Do you want to run this script with sudo privileges for installing packages? (yes/no) " sudo_perms

if [[ "$sudo_perms" =~ ^[Yy](es)?$ ]]; then
    if ! sudo -v; then
        warning "Failed to get sudo privileges. Continuing without package installation."
    else
        # Update package lists
        status "Updating package lists..."
        sudo apt update

        # List of apt packages to install
        apt_packages=(
            git
            curl
            build-essential
        )

        # Install apt packages
        status "Installing system packages..."
        for pkg in "${apt_packages[@]}"; do
            if ! dpkg -l | grep -q "^ii\s*$pkg\s"; then
                status "Installing $pkg..."
                sudo apt install -y "$pkg"
            else
                status "$pkg is already installed via apt."
            fi
        done
    fi
else
    status "Skipping package installation and proceeding with symbolic linking."
fi

# Symbolically link config files
status "Setting up configuration files..."
declare -A files=(
    ["$HOME/.dotfiles/bash/.bashrc"]="$HOME/.bashrc"
    ["$HOME/.dotfiles/bash/.bash_aliases"]="$HOME/.bash_aliases"
    ["$HOME/.dotfiles/bash/.bash_profile"]="$HOME/.bash_profile"
    ["$HOME/.dotfiles/bash/.bash_logout"]="$HOME/.bash_logout"
    ["$HOME/.dotfiles/git/.gitconfig"]="$HOME/.gitconfig"
    ["$HOME/.dotfiles/vim/.vimrc"]="$HOME/.vimrc"
)

for source_file in "${!files[@]}"; do
    target_file="${files[$source_file]}"
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target_file")"
    
    # Backup existing file if it's not a symlink
    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        warning "Backing up existing file: $target_file"
        mv "$target_file" "${target_file}.bak"
    fi
    
    # Remove existing symlink if it exists
    if [ -L "$target_file" ]; then
        rm -f "$target_file"
    fi
    
    # Create new symlink
    if ln -s "$source_file" "$target_file" 2>/dev/null; then
        status "Linked: $source_file -> $target_file"
    else
        warning "Failed to link: $source_file -> $target_file"
    fi
done

# Install Homebrew if not installed
if ! command_exists brew; then
    status "Homebrew not found, installing..."
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        # Add Homebrew to PATH for this session
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        warning "Failed to install Homebrew. Some packages may not be installed."
    fi
else
    status "Homebrew found, updating..."
    brew update
fi

# Homebrew packages
if command_exists brew; then
    status "Installing/updating Homebrew packages..."
    brew_packages=(
        cmake
        diff-so-fancy
        git
        lazygit
        llvm
        lsd
        make
        neovim
        oh-my-posh
        valgrind
    )

    # Get list of installed packages
    installed_packages=$(brew list --formula)

    for package in "${brew_packages[@]}"; do
        if echo "$installed_packages" | grep -q "^${package}$"; then
            status "$package is already installed via Homebrew."
        else
            status "Installing $package..."
            if ! brew install "$package"; then
                warning "Failed to install $package"
            fi
        fi
    done
else
    warning "Homebrew not available. Skipping package installation."
fi

status "Installation complete!"
