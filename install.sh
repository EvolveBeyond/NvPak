#!/usr/bin/env bash

# NvPak Professional Installer (2026 Edition)
# Philosophy: Speed, Cleanliness, Reliability

set -euo pipefail

# --- UI & Colors ---
BOLD="$(tput bold 2>/dev/null || echo '')"
RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
BLUE="$(tput setaf 4 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
RESET="$(tput sgr0 2>/dev/null || echo '')"

info()    { printf "${BLUE}${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }
warn()    { printf "${YELLOW}${BOLD}warn${RESET}    %s\n" "$1"; }
error()   { printf "${RED}${BOLD}error${RESET}   %s\n" "$1"; exit 1; }

# --- Configuration ---
NVPAK_REPO="https://github.com/Pakrohk-DotFiles/NvPak.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
MIN_NVIM="0.10.0"

# --- Functions ---
command_exists() { command -v "$1" >/dev/null 2>&1; }

get_os() {
    case "$(uname -s)" in
        Linux*)   echo "linux" ;;
        Darwin*)  echo "macos" ;;
        *)        echo "unknown" ;;
    esac
}

install_deps() {
    local os=$(get_os)
    info "Environment: $os. Installing dependencies..."
    case "$os" in
        macos)
            if ! command_exists brew; then error "Homebrew not found. Install from https://brew.sh/"; fi
            brew install neovim git curl ripgrep fd
            ;;
        linux)
            if command_exists apt-get; then
                sudo apt-get update && sudo apt-get install -y neovim git curl ripgrep fd-find xclip wl-clipboard
            elif command_exists pacman; then
                sudo pacman -Syu --noconfirm neovim git curl ripgrep fd xclip wl-clipboard
            elif command_exists dnf; then
                sudo dnf install -y neovim git curl ripgrep fd-find xclip wl-clipboard
            else
                warn "Could not auto-install. Ensure neovim(>=0.10), git, curl, ripgrep, fd are present."
            fi
            ;;
        *) error "Unsupported OS." ;;
    esac
}

check_version() {
    if ! command_exists nvim; then return 1; fi
    local ver=$(nvim --version | head -n1 | cut -d' ' -f2 | sed 's/^v//')
    [[ "$(printf '%s\n%s' "$MIN_NVIM" "$ver" | sort -V | head -n1)" == "$MIN_NVIM" ]]
}

main() {
    clear
    printf "${MAGENTA}${BOLD}NvPak Pro Installer${RESET}\n\n"

    install_deps

    if ! check_version; then warn "Neovim version < $MIN_NVIM. Please update."; fi

    if [ -d "$CONFIG_DIR" ]; then
        if [ -d "$CONFIG_DIR/.git" ]; then
            info "Updating NvPak..."
            git -C "$CONFIG_DIR" pull || warn "Update failed."
        else
            warn "Existing config found. Backing up..."
            mv "$CONFIG_DIR" "${CONFIG_DIR}.bak.$(date +%s)"
            git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
        fi
    else
        info "Cloning NvPak..."
        git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
    fi

    info "Bootstrapping plugins..."
    nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 || true

    success "Done! Open Neovim with 'nvim'."
}

main "$@"
