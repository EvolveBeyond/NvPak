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
DRY_RUN=0

# --- Functions ---
usage() {
    cat <<EOF
NvPak Installer v2026.08.30
Usage: $0 [options]

Options:
  --dry-run        Show what would be done without making changes
  --help           Show this help

Environment:
  NVPAK_REPO       Override repository URL
  NO_COLOR         Disable colored output
EOF
}
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
            sudo -n $install_cmd $pkg 2>/dev/null || warn "Could not install '$pkg' (needs sudo/TTY)."
        else
            warn "Skipping '$pkg'. Some features might not work."
        fi
    fi
}

main() {
    # Parse arguments
    while [ $# -gt 0 ]; do
        case "$1" in
            --dry-run)  DRY_RUN=1 ;;
            --help)     usage; exit 0 ;;
            *)          warn "Unknown option: $1" ;;
        esac
        shift
    done

    # clear might not be available or desired in all environments
    if command_exists clear; then clear; fi
    printf "${MAGENTA}${BOLD}NvPak Pro Installer (Zen Edition)${RESET}\n\n"

    PM_INSTALL=""
    # Detect Package Manager & Update Repository Lists (ONLY lists)
    if [ "${DRY_RUN:-0}" = "1" ]; then
        info "[dry-run] Would detect package manager and update repos"
    elif command_exists pacman; then
        # Index update is non-essential: warn, don't hard-fail (sudo may need a TTY)
        if sudo -n pacman -Sy 2>/dev/null; then
            info "Updated pacman repositories."
        else
            warn "Could not update pacman index (needs sudo/TTY). Continuing if packages exist."
        fi
        PM_INSTALL="pacman -S --noconfirm"
    elif command_exists apt-get; then
        # Non-essential index update: warn, don't hard-fail
        if sudo -n apt-get update 2>/dev/null; then
            info "Updated apt repositories."
        else
            warn "Could not update apt index (needs sudo/TTY). Continuing if packages exist."
        fi
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
    if [ "${DRY_RUN:-0}" = "1" ]; then
        info "[dry-run] Would clone/update to: $CONFIG_DIR"
    elif [ ! -d "$CONFIG_DIR" ]; then
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

    if [ "${DRY_RUN:-0}" = "1" ]; then
        info "[dry-run] Would bootstrap plugins"
        success "Dry run complete. Run without --dry-run to install."
        return 0
    fi

    info "Bootstrapping plugins..."
    (
        nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 &
        pid=$!
        ( sleep 120 && kill $pid 2>/dev/null ) &
        timer=$!
        wait $pid 2>/dev/null
        kill $timer 2>/dev/null
    ) || warn "Plugin bootstrap had issues. Run ':Rocks sync' manually."

    success "NvPak installation complete!"
}

main "$@"
