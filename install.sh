#!/usr/bin/env bash

# Function to print colored messages
print_message() {
  local color_code="$1"
  local message="$2"
  echo -e "\033[${color_code}m${message}\033[0m"
}

info() {
  print_message "34" "INFO: $1" # Blue
}

success() {
  print_message "32" "SUCCESS: $1" # Green
}

warning() {
  print_message "33" "WARNING: $1" # Yellow
}

error() {
  print_message "31" "ERROR: $1" # Red
  exit 1
}

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Detect OS
OS=""
if [[ "$(uname)" == "Linux" ]]; then
  OS="Linux"
  if command_exists apt-get; then
    PM="sudo apt-get install -y"
    PM_UPDATE="sudo apt-get update"
  elif command_exists yum; then
    PM="sudo yum install -y"
    PM_UPDATE="sudo yum update"
  elif command_exists dnf; then
    PM="sudo dnf install -y"
    PM_UPDATE="sudo dnf check-update"
  elif command_exists pacman; then
    PM="sudo pacman -Syu --noconfirm" # Pacman usually updates and installs in one go
    PM_UPDATE="" # No separate update needed before install usually
  elif grep -q "Android" /proc/version; then
    OS="Android"
    if command_exists pkg; then
        PM="pkg install -y"
        PM_UPDATE="pkg update -y && pkg upgrade -y"
    else
        error "Termux 'pkg' package manager not found. Please install it first."
    fi
  else
    error "Unsupported Linux distribution. Please install dependencies manually."
  fi
elif [[ "$(uname)" == "Darwin" ]]; then
  OS="Mac"
  if command_exists brew; then
    PM="brew install"
    PM_UPDATE="brew update"
  else
    error "Homebrew not found. Please install Homebrew first: https://brew.sh/"
  fi
else
  # Rudimentary check for Windows, assuming Git Bash or WSL
  # A dedicated PowerShell script is better for Windows native support
  if [[ -n "$WINDIR" ]] || [[ "$(uname -o 2>/dev/null)" == "Msys" ]] || [[ "$(uname -o 2>/dev/null)" == "Cygwin" ]]; then
    OS="Windows_Shell" # Indicates a Unix-like shell on Windows
    info "Detected Windows with a Unix-like shell (Git Bash, WSL, Cygwin, Msys)."
    info "Attempting to use common commands. For best results, use PowerShell or ensure your environment has necessary tools."
    # No standard package manager here, dependencies might need manual setup or specific instructions.
    # We'll try to check for common tools but installation will be tricky.
  else
    error "Unsupported operating system: $(uname). This script supports Linux, macOS, and Unix-like shells on Windows."
  fi
fi

info "Detected OS: $OS"

# --- Dependency Installation Placeholder ---
# Will be filled in subsequent steps

# --- Clone NvPak ---
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVPAK_REPO_URL="https://github.com/Pakrohk-DotFiles/NvPak.git"

# --- Main Logic ---
main() {
  info "Starting NvPak installation..."

  # Update package manager (if applicable and defined)
  if [[ -n "$PM_UPDATE" ]]; then
    info "Updating package manager..."
    eval "$PM_UPDATE" || warning "Failed to update package manager. Proceeding with caution."
  fi

  # Install core dependencies
  info "Installing core dependencies (git, curl, unzip, neovim)..."
  CORE_DEPS=("git" "curl" "unzip" "nvim") # nvim might be named differently (neovim)

  if [[ "$OS" == "Linux" || "$OS" == "Mac" ]]; then
    for dep in "${CORE_DEPS[@]}"; do
      if ! command_exists "$dep"; then
        # Special handling for nvim package name
        if [[ "$dep" == "nvim" ]]; then
            if command_exists nvim; then
                info "Neovim is already installed."
                continue
            fi
            info "Installing Neovim..."
            if [[ "$OS" == "Mac" ]]; then
                eval "$PM neovim" || error "Failed to install Neovim."
            elif [[ "$PM" == "sudo apt-get install -y" ]]; then # Debian/Ubuntu
                # Add Neovim PPA for latest stable or nightly
                # For simplicity, let's try installing 'neovim' package directly.
                # Users might need to add PPA for newer versions.
                eval "$PM neovim" || error "Failed to install Neovim. You might need to add a PPA for the latest version."
            else # Other Linux distros
                eval "$PM neovim" || eval "$PM nvim" || error "Failed to install Neovim."
            fi
        else
            info "Installing $dep..."
            eval "$PM $dep" || error "Failed to install $dep."
        fi
      else
        info "$dep is already installed."
      fi
    done
  elif [[ "$OS" == "Android" ]]; then
    # Termux specific
    info "Installing core dependencies for Termux (git, curl, unzip, neovim)..."
    eval "$PM git curl unzip neovim" || error "Failed to install core dependencies on Termux."
  elif [[ "$OS" == "Windows_Shell" ]]; then
    info "Please ensure Git, Curl, Unzip, and Neovim are installed and in your PATH."
    # Attempt to check, but installation is manual here
    for dep in "${CORE_DEPS[@]}"; do
        if ! command_exists "$dep"; then
            if [[ "$dep" == "nvim" ]] && command_exists "neovim"; then # check for neovim as well
                 info "Neovim (as neovim) is already installed."
            else
                warning "$dep not found. Please install it manually."
            fi
        else
            info "$dep is already installed."
        fi
    done
  fi

  # Install additional tools (ripgrep, clipboard tools)
  info "Installing additional tools (ripgrep, fd, clipboard tools)..."
  if [[ "$OS" == "Linux" ]]; then
    # Ripgrep
    if ! command_exists rg; then
      info "Installing ripgrep..."
      eval "$PM ripgrep" || warning "Failed to install ripgrep. Telescope search might be slower."
    else
      info "ripgrep is already installed."
    fi
    # fd
    if ! command_exists fd; then
      info "Installing fd-find (often packaged as fd-find, binary is fd)..."
      eval "$PM fd-find" || eval "$PM fd" || warning "Failed to install fd. Telescope might use alternative finders."
    else
      info "fd is already installed."
    fi
    # Clipboard
    if ! command_exists xclip && ! command_exists xsel && ! command_exists wl-copy; then
      info "Installing clipboard tools (xclip/xsel for Xorg, wl-clipboard for Wayland)..."
      if [[ -n "$WAYLAND_DISPLAY" ]]; then
        eval "$PM wl-clipboard" || warning "Failed to install wl-clipboard for Wayland."
      else
        eval "$PM xclip" || eval "$PM xsel" || warning "Failed to install xclip or xsel for Xorg."
      fi
    else
      info "Clipboard tool (xclip, xsel, or wl-clipboard) is already installed."
    fi
  elif [[ "$OS" == "Mac" ]]; then
    if ! command_exists rg; then info "Installing ripgrep..."; eval "$PM ripgrep" || warning "Failed to install ripgrep."; else info "ripgrep is already installed."; fi
    if ! command_exists fd; then info "Installing fd..."; eval "$PM fd" || warning "Failed to install fd."; else info "fd is already installed."; fi
    # Clipboard on macOS is usually handled by pbcopy/pbpaste, which are built-in.
  elif [[ "$OS" == "Android" ]]; then
    if ! command_exists rg; then info "Installing ripgrep for Termux..."; eval "$PM ripgrep" || warning "Failed to install ripgrep."; else info "ripgrep is already installed."; fi
    if ! command_exists fd; then info "Installing fd for Termux..."; eval "$PM fd" || warning "Failed to install fd."; else info "fd is already installed."; fi
    info "For clipboard on Termux, use termux-clipboard-get/set (install with 'pkg install termux-api')."
    if ! command_exists termux-clipboard-get; then
        info "Installing termux-api for clipboard..."
        eval "$PM termux-api" || warning "Failed to install termux-api for clipboard access."
    else
        info "termux-api (for clipboard) is already installed."
    fi
  elif [[ "$OS" == "Windows_Shell" ]]; then
    info "Please ensure ripgrep and fd are installed and in your PATH for Telescope."
    if ! command_exists rg; then warning "ripgrep (rg) not found. Please install it manually."; else info "ripgrep is already installed."; fi
    if ! command_exists fd; then warning "fd not found. Please install it manually."; else info "fd is already installed."; fi
    info "Clipboard on Windows is typically handled by Neovim itself or via PowerShell/WSL integrations."
  fi

  # Pynvim (optional, for Python devs)
  if command_exists pip3; then
    if ! python3 -c "import pynvim" &> /dev/null; then
      info "pynvim (Python 3) not found. Installing..."
      pip3 install --user pynvim || warning "Failed to install pynvim with pip3. Python integration might not work."
    else
      info "pynvim is already installed."
    fi
  elif command_exists pip; then
     if ! python -c "import pynvim" &> /dev/null; then
      info "pynvim (Python 2/default) not found. Installing..."
      pip install --user pynvim || warning "Failed to install pynvim with pip. Python integration might not work."
    else
      info "pynvim is already installed."
    fi
  else
    warning "pip/pip3 not found. Cannot install pynvim automatically. If you are a Python developer, please install it manually."
  fi


  # Clone or update NvPak repository
  info "Setting up NvPak configuration directory: $NVIM_CONFIG_DIR"
  if [ -d "$NVIM_CONFIG_DIR" ]; then
    info "NvPak directory already exists. Checking for updates..."
    cd "$NVIM_CONFIG_DIR" || error "Could not cd into $NVIM_CONFIG_DIR"
    if [ -d ".git" ]; then
      current_remote=$(git remote get-url origin)
      if [[ "$current_remote" == "$NVPAK_REPO_URL" ]]; then
        info "Pulling latest changes from NvPak repository..."
        git pull || warning "Failed to pull latest changes. Your configuration might be outdated."
      else
        warning "The existing directory $NVIM_CONFIG_DIR is a git repository, but not for NvPak ($current_remote)."
        warning "Please move or backup your existing Neovim configuration and re-run the script."
        # Potentially offer to backup and clone, but for now, let's be safe.
        # read -p "Do you want to backup the existing directory and clone NvPak? (y/N): " backup_confirm
        # if [[ "$backup_confirm" =~ ^[Yy]$ ]]; then
        #   mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}.backup.$(date +%s)"
        #   info "Backed up existing config to ${NVIM_CONFIG_DIR}.backup.$(date +%s)"
        #   info "Cloning NvPak repository..."
        #   git clone --depth 1 "$NVPAK_REPO_URL" "$NVIM_CONFIG_DIR" || error "Failed to clone NvPak repository."
        # else
        #   error "Installation aborted by user."
        # fi
        error "Please backup/move your existing Neovim config from $NVIM_CONFIG_DIR and re-run."
      fi
    else
      warning "$NVIM_CONFIG_DIR exists but is not a git repository. It might be an old NvPak install or a custom config."
      error "Please backup/move your existing Neovim config from $NVIM_CONFIG_DIR and re-run."
    fi
    cd - > /dev/null # Go back to previous directory
  else
    info "Cloning NvPak repository to $NVIM_CONFIG_DIR..."
    git clone --depth 1 "$NVPAK_REPO_URL" "$NVIM_CONFIG_DIR" || error "Failed to clone NvPak repository."
  fi

  # Nerd Fonts Installation (Guidance)
  info "--- Nerd Fonts ---"
  info "For the best visual experience, please install a Nerd Font."
  info "You can find them at: https://www.nerdfonts.com/"
  info "After installation, set it as your terminal font."
  echo "" # Newline for readability

  # Initial Neovim run for plugin installation
  info "Running Neovim for the first time to install plugins via rocks.nvim..."
  info "This might take a few moments. Please wait for Neovim to fully load and install plugins."
  info "If prompted by rocks.nvim, confirm any installations."

  if command_exists nvim; then
    nvim --headless "+qa" # Attempt a headless quit to trigger initial setup if possible
    info "Neovim headless setup attempt complete. Starting Neovim..."
    info "Please close Neovim after plugins are installed (you might see messages from rocks.nvim)."
    nvim
  else
    error "Neovim command (nvim) not found even after installation attempt. Please check your PATH."
  fi

  success "NvPak installation script finished!"
  info "Please restart your terminal or source your shell configuration if you installed new tools."
  info "Open Neovim with 'nvim'."
}

# --- Entry Point ---
main

exit 0
