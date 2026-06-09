#!/usr/bin/env bash

# NvPak Professional Installer (2026 Edition)
# Philosophy: Non-invasive, Clean, Reliable

set -euo pipefail

# --- UI & Colors ---
BOLD="$(tput bold 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
RESET="$(tput sgr0 2>/dev/null || echo '')"

info()    { printf "${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }
warn()    { printf "${YELLOW}${BOLD}warn${RESET}    %s\n" "$1"; }

# --- Configuration ---
NVPAK_REPO="https://github.com/Pakrohk-DotFiles/NvPak.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# --- Functions ---
command_exists() { command -v "$1" >/dev/null 2>&1; }

confirm() {
    read -p "${BOLD}question${RESET} $1 [y/N] " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

install_package() {
    local pkg=$1
    local install_cmd=$2
    if ! command_exists "$pkg"; then
        if confirm "Package '$pkg' is missing. Install it?"; then
            sudo $install_cmd "$pkg"
        else
            warn "Skipping '$pkg'. Some features might not work."
        fi
    fi
}

main() {
    clear
    printf "${MAGENTA}${BOLD}NvPak Pro Installer (Zen Edition)${RESET}\n\n"

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
        PM_INSTALL=""
    fi

    # Install Dependencies
    if [[ -n "$PM_INSTALL" ]]; then
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
            git -C "$CONFIG_DIR" pull || warn "Update failed."
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
