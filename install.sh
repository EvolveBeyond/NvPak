#!/usr/bin/env bash

# NvPak Professional Installer
# Philosophy: Simplicity, Cleanliness, Reliability

set -euo pipefail

# --- Colors & UI ---
BOLD="$(tput bold 2>/dev/null || echo '')"
GREY="$(tput setaf 0 2>/dev/null || echo '')"
RED="$(tput setaf 1 2>/dev/null || echo '')"
GREEN="$(tput setaf 2 2>/dev/null || echo '')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '')"
BLUE="$(tput setaf 4 2>/dev/null || echo '')"
MAGENTA="$(tput setaf 5 2>/dev/null || echo '')"
CYAN="$(tput setaf 6 2>/dev/null || echo '')"
RESET="$(tput sgr0 2>/dev/null || echo '')"

info()    { printf "${BLUE}${BOLD}info${RESET}  %s\n" "$1"; }
success() { printf "${GREEN}${BOLD}success${RESET} %s\n" "$1"; }
warn()    { printf "${YELLOW}${BOLD}warn${RESET}    %s\n" "$1"; }
error()   { printf "${RED}${BOLD}error${RESET}   %s\n" "$1"; exit 1; }

# --- Constants ---
NVPAK_REPO="https://github.com/Pakrohk-DotFiles/NvPak.git"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
MIN_NVIM_VER="0.10.0"

# --- Functions ---
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

get_os() {
  case "$(uname -s)" in
    Linux*)   echo "linux" ;;
    Darwin*)  echo "macos" ;;
    *)        echo "unknown" ;;
  esac
}

check_nvim_version() {
  if ! command_exists nvim; then return 1; fi
  local ver
  ver=$(nvim --version | head -n1 | cut -d' ' -f2 | sed 's/^v//')
  if [[ "$(printf '%s\n%s' "$MIN_NVIM_VER" "$ver" | sort -V | head -n1)" == "$MIN_NVIM_VER" ]]; then
    return 0
  fi
  return 1
}

install_deps() {
  local os=$(get_os)
  info "Detecting environment and installing dependencies..."

  case "$os" in
    macos)
      if ! command_exists brew; then
        error "Homebrew not found. Please install it first: https://brew.sh/"
      fi
      brew install neovim git curl ripgrep fd
      ;;
    linux)
      if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y neovim git curl ripgrep fd-find xclip wl-clipboard
      elif command_exists pacman; then
        sudo pacman -Syu --noconfirm neovim git curl ripgrep fd xclip wl-clipboard
      elif command_exists dnf; then
        sudo dnf install -y neovim git curl ripgrep fd-find xclip wl-clipboard
      else
        warn "Unsupported package manager. Please ensure neovim(>=0.10), git, curl, ripgrep, and fd are installed."
      fi
      ;;
    *)
      error "Unsupported OS. Please install dependencies manually."
      ;;
  esac
}

setup_config() {
  if [ -d "$NVIM_CONFIG_DIR" ]; then
    if [ -d "$NVIM_CONFIG_DIR/.git" ]; then
      info "Updating NvPak..."
      git -C "$NVIM_CONFIG_DIR" pull || warn "Failed to pull updates."
    else
      warn "Existing config found at $NVIM_CONFIG_DIR. Backing up..."
      mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}.bak.$(date +%s)"
      git clone --depth 1 "$NVPAK_REPO" "$NVIM_CONFIG_DIR"
    fi
  else
    info "Cloning NvPak..."
    git clone --depth 1 "$NVPAK_REPO" "$NVIM_CONFIG_DIR"
  fi
}

main() {
  clear
  printf "${MAGENTA}${BOLD}"
  printf "  _   _      _____           \n"
  printf " | \ | |    |  __ \          \n"
  printf " |  \| |  __| |__) |_ _  | | \n"
  printf " | . \` | / _\` |  ___/ _\` | |/ /\n"
  printf " | |\  || (_| | |  | (_| |   < \n"
  printf " |_| \_| \__,_|_|   \__,_|_|\_\\ \n"
  printf "${RESET}\n"
  info "Welcome to the NvPak professional installer."

  install_deps

  if ! check_nvim_version; then
    warn "Neovim version is below $MIN_NVIM_VER. Some features may not work."
  fi

  setup_config

  info "Bootstrapping plugins (this may take a minute)..."
  nvim --headless "+Rocks sync" "+qa" >/dev/null 2>&1 || true

  success "NvPak has been installed successfully!"
  info "Open Neovim by typing 'nvim'."
  info "Don't forget to install a Nerd Font for the best experience."
}

main "$@"
