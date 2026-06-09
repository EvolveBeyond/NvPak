#!/usr/bin/env bash
# NvPak Professional Installer (2026 Edition)
set -euo pipefail

# UI & Colors
BOLD="$(tput bold 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
RESET="$(tput sgr0 2>/dev/null || echo '')"

info()    { printf "${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }

NVPAK_REPO="https://github.com/Pakrohk-DotFiles/NvPak.git"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

main() {
    clear
    printf "${MAGENTA}${BOLD}NvPak Pro Installer (Modern Zen 2026)${RESET}\n\n"

    # Setup Directory
    if [ ! -d "$CONFIG_DIR" ]; then
        info "Cloning NvPak..."
        git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
    else
        info "Checking existing config at $CONFIG_DIR..."
        if [ -d "$CONFIG_DIR/.git" ]; then
            git -C "$CONFIG_DIR" remote set-url origin "$NVPAK_REPO"
            git -C "$CONFIG_DIR" pull || info "Update failed, proceeding with local files."
        else
            info "Backing up old config..."
            mv "$CONFIG_DIR" "${CONFIG_DIR}.bak.$(date +%s)"
            git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
        fi
    fi

    info "Bootstrapping Modern Zen plugins..."
    nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 || true

    success "Installation Complete! Type 'nvim' to start."
}

main "$@"
