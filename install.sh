#!/usr/bin/env bash
set -euo pipefail
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
    printf "${MAGENTA}${BOLD}NvPak Pro Installer${RESET}\n\n"
    if [ ! -d "$CONFIG_DIR" ]; then
        info "Cloning NvPak..."
        git clone --depth 1 "$NVPAK_REPO" "$CONFIG_DIR"
    else
        info "Updating NvPak..."
        git -C "$CONFIG_DIR" pull
    fi
    info "Bootstrapping..."
    nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 || true
    success "Done!"
}
main "$@"
