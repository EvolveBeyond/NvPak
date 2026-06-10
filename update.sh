#!/bin/sh

# NvPak Smart Update Script (2026 Edition)
# Philosophy: User-aware, Conflict-safe, Reliable

set -eu

# --- UI & Colors ---
if [ -t 1 ]; then
    BOLD="$(tput bold 2>/dev/null || printf '')"
    RED="$(tput setaf 1 2>/dev/null || printf '')"
    GREEN="$(tput setaf 2 2>/dev/null || printf '')"
    YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
    BLUE="$(tput setaf 4 2>/dev/null || printf '')"
    MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
    RESET="$(tput sgr0 2>/dev/null || printf '')"
else
    BOLD=""
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    RESET=""
fi

info()    { printf "${BLUE}${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }
warn()    { printf "${YELLOW}${BOLD}warn${RESET}    %s\n" "$1"; }
error()   { printf "${RED}${BOLD}error${RESET}   %s\n" "$1"; }

# --- Constants ---
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

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

check_conflicts() {
    info "Checking for potential conflicts..."
    # Fetch latest without merging
    git fetch origin main >/dev/null 2>&1 || { error "Failed to fetch from remote."; exit 1; }

    # Check if there are local changes
    if ! git diff --quiet; then
        warn "You have uncommitted local changes."
        git status --short
        if ! confirm "Proceeding might overwrite these changes. Continue?"; then
            error "Update aborted by user."
            exit 1
        fi
    fi

    # Check for merge conflicts if we were to pull
    if git merge-tree "$(git merge-base HEAD origin/main)" HEAD origin/main | grep -q "<<<<<<<"; then
        warn "Automatic merge might result in conflicts."
        if confirm "Do you want to backup your current config and force update?"; then
            backup_dir="${CONFIG_DIR}.bak.$(date +%s)"
            cp -r "$CONFIG_DIR" "$backup_dir"
            success "Backup created at $backup_dir"
            info "Force updating to the latest version..."
            git reset --hard origin/main
            return 0
        else
            info "Attempting to merge anyway..."
            if git pull origin main; then
                success "Merged successfully."
            else
                error "Merge failed. Please resolve conflicts manually in $CONFIG_DIR."
                exit 1
            fi
        fi
    else
        info "No obvious conflicts detected. Pulling..."
        git pull origin main
    fi
}

main() {
    if command_exists clear; then clear; fi
    printf "${MAGENTA}${BOLD}NvPak Smart Update Tool${RESET}\n\n"

    if [ ! -d "$CONFIG_DIR/.git" ]; then
        error "$CONFIG_DIR is not a git repository. Cannot update automatically."
        exit 1
    fi

    cd "$CONFIG_DIR"

    check_conflicts

    info "Syncing plugins..."
    nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 || true

    success "NvPak updated to the latest version!"
}

main "$@"
