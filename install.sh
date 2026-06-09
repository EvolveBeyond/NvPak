#!/usr/bin/env bash
# NvPak Professional Installer (Unix-like) - June 2026
set -euo pipefail

BOLD="$(tput bold 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
RESET="$(tput sgr0 2>/dev/null || echo '')"

info()    { printf "${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }
error()   { printf "$(tput setaf 1 2>/dev/null || echo '')error$(tput sgr0 2>/dev/null || echo '')  %s\n" "$1" >&2; exit 1; }

NVPAK_REPO="https://github.com/EvolveBeyond/NvPak.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

main() {
    clear
    printf "${MAGENTA}${BOLD}NvPak Pro Installer (v2026)${RESET}\n\n"

    # Check for Git
    if ! command -v git &>/dev/null; then
        error "Git is not installed. Please install git and try again."
    fi

    # Check for Neovim version
    if ! command -v nvim &>/dev/null; then
        error "Neovim is not installed. Please install Neovim v0.10.0+ and try again."
    fi

    NVIM_VERSION=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
    if [[ $(printf '%s\n0.10.0\n' "$NVIM_VERSION" | sort -V | head -n1) != "0.10.0" ]]; then
        error "NvPak requires Neovim v0.10.0 or higher. You have $NVIM_VERSION."
    fi

    if [ ! -d "$CONFIG_DIR" ]; then
        info "Cloning NvPak into $CONFIG_DIR..."
        git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
    else
        if [ -d "$CONFIG_DIR/.git" ]; then
            info "Updating existing NvPak in $CONFIG_DIR..."
            git -C "$CONFIG_DIR" pull
        else
            error "$CONFIG_DIR exists and is not a git repository. Please backup and remove it before running this script."
        fi
    fi

    info "Bootstrapping plugins and configuration..."
    # We use rocks.nvim for management
    nvim --headless "+Rocks sync" "+qa" || info "Note: Initial sync might have reported warnings, but proceeding..."

    success "NvPak has been successfully installed/updated!"
    info "Start it by running: nvim"
}

main "$@"
