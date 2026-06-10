#!/bin/sh

# NvPak Professional Installer (2026 Edition)
# Philosophy: Non-invasive, Clean, Reliable

set -eu

# --- UI & Colors ---
# Check if stdout is a terminal
if [ -t 1 ]; then
    BOLD="$(tput bold 2>/dev/null || printf '')"
    GREEN="$(tput setaf 2 2>/dev/null || printf '')"
    YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
    MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
    RESET="$(tput sgr0 2>/dev/null || printf '')"
else
    BOLD=""
    GREEN=""
    YELLOW=""
    MAGENTA=""
    RESET=""
fi

info()    { printf "${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }
warn()    { printf "${YELLOW}${BOLD}warn${RESET}    %s\n" "$1"; }

# --- Configuration ---
NVPAK_REPO="https://github.com/Pakrohk-DotFiles/NvPak.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# --- Functions ---
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

confirm() {
    printf "${BOLD}question${RESET} %s [y/N] " "$1"
    read -r REPLY
    case "$REPLY" in
        [Yy]*) return 0 ;;
        *) return 1 ;;
    esac
}

install_package() {
    pkg="$1"
    install_cmd="$2"
    if ! command_exists "$pkg"; then
        if confirm "Package '$pkg' is missing. Install it?"; then
            eval "sudo $install_cmd $pkg"
        else
            warn "Skipping '$pkg'. Some features might not work."
        fi
    fi
}

main() {
    # clear might not be available or desired in all environments
    if command_exists clear; then clear; fi
    printf "${MAGENTA}${BOLD}NvPak Pro Installer (Zen Edition)${RESET}\n\n"

    PM_INSTALL=""
    # Detect Package Manager & Update Repository Lists (ONLY lists)
    if command_exists pacman; then
        info "Updating pacman repositories..."
        sudo pacman -Sy
        PM_INSTALL="pacman -S --noconfirm"
    elif command_exists apt-get; then
        info "Updating apt repositories..."
        sudo apt-get update
        PM_INSTALL="apt-get install -y"
    elif command_exists dnf; then
        PM_INSTALL="dnf install -y"
    else
        warn "Unsupported package manager. Please ensure git, neovim, ripgrep, fd are installed."
    fi

    # Install Dependencies
    if [ -n "$PM_INSTALL" ]; then
        install_package "git" "$PM_INSTALL"
        install_package "nvim" "$PM_INSTALL"
        install_package "rg" "$PM_INSTALL"
        install_package "fd" "$PM_INSTALL"
    fi

    # Setup Directory
    if [ ! -d "$CONFIG_DIR" ]; then
        info "Cloning NvPak..."
        git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
    else
        info "Updating NvPak..."
        if [ -d "$CONFIG_DIR/.git" ]; then
            (cd "$CONFIG_DIR" && git pull) || warn "Update failed."
        else
            if confirm "Directory $CONFIG_DIR is not a git repo. Backup and re-clone?"; then
                mv "$CONFIG_DIR" "${CONFIG_DIR}.bak.$(date +%s)"
                git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
            fi
        fi
    fi

    info "Bootstrapping plugins..."
    nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 || true

    success "NvPak installation complete!"
}

main "$@"
