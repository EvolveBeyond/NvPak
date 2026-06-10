#!/bin/sh

# NvPak CLI Helper
# Strictly POSIX compliant

set -eu

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

usage() {
    printf "Usage: nvpak [update|sync|clean|help]\n"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

case "$1" in
    update)
        if [ -x "$CONFIG_DIR/update.sh" ]; then
            "$CONFIG_DIR/update.sh"
        else
            printf "Error: Update script not found or not executable.\n"
            exit 1
        fi
        ;;
    sync)
        nvim --headless "+Rocks sync" "+qa"
        ;;
    clean)
        nvim --headless "+Rocks prune" "+qa"
        ;;
    help)
        usage
        ;;
    *)
        printf "Unknown command: %s\n" "$1"
        usage
        ;;
esac
