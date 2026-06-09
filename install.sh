#!/usr/bin/env bash

# NvPak Installer Script (Shell version)
# Responsibilities:
# 1. Ensure Git and Neovim are installed.
# 2. Clone/update the NvPak repository.
# 3. Trigger the Lua-based installer within NvPak.

# --- Configuration ---
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVPAK_REPO_URL="https://github.com/Pakrohk-DotFiles/NvPak.git"
NVPAK_INSTALLER_LUA_MODULE="nvpak.core.installer" # Lua module to run e.g., require('nvpak.core.installer').init()

# --- Helper Functions ---
print_message() {
  local color_code="$1"
  local message="$2"
  echo -e "\033[${color_code}m${message}\033[0m"
}

info() { print_message "34" "INFO: $1"; } # Blue
success() { print_message "32" "SUCCESS: $1"; } # Green
warning() { print_message "33" "WARNING: $1"; } # Yellow
error_exit() {
  print_message "31" "ERROR: $1" >&2 # Red, to stderr
  exit 1
}

command_exists() {
  command -v "$1" &>/dev/null
}

# --- Prerequisite Installation ---
install_prerequisites() {
  local os_type="$1"
  local pm_cmd="$2"
  local pm_update_cmd="$3"
  local missing_deps=()

  # Update package manager if an update command is defined
  if [[ -n "$pm_update_cmd" ]]; then
    info "Updating package list via $pm_update_cmd..."
    eval "$pm_update_cmd" || warning "Failed to update package list. Proceeding with caution."
  fi

  info "Checking for Git..."
  if ! command_exists git; then
    info "Git not found."
    missing_deps+=("git")
  else
    info "Git is installed."
  fi

  info "Checking for Neovim..."
  if ! command_exists nvim; then
    info "Neovim (nvim) not found."
    missing_deps+=("neovim") # Use 'neovim' as common package name, 'nvim' for command
  else
    info "Neovim is installed."
  fi

  if [[ ${#missing_deps[@]} -gt 0 ]]; then
    info "Attempting to install missing prerequisites: ${missing_deps[*]} using '$pm_cmd'..."
    for dep_pkg_name in "${missing_deps[@]}"; do
      # Handle common package name variations (e.g., neovim vs nvim)
      local actual_pkg_name="$dep_pkg_name"
      if [[ "$dep_pkg_name" == "neovim" && "$os_type" == "Linux" ]]; then
        # On some systems, the package is 'nvim', on others 'neovim'
        # We'll try 'neovim' first as it's more common for explicit install
        # If 'neovim' fails and 'nvim' is the command, the Lua installer can handle specific checks.
        : # Keep actual_pkg_name as neovim
      elif [[ "$dep_pkg_name" == "neovim" && "$os_type" == "Android" ]]; then
        actual_pkg_name="neovim" # Termux uses 'neovim'
      fi

      info "Installing $actual_pkg_name..."
      if eval "$pm_cmd $actual_pkg_name"; then
        success "$actual_pkg_name installed successfully."
      else
        warning "Failed to install $actual_pkg_name automatically."
        warning "Please install it manually and re-run this script."
        if [[ "$actual_pkg_name" == "neovim" ]]; then
            warning "For Neovim, see: https://github.com/neovim/neovim/wiki/Installing-Neovim"
        elif [[ "$actual_pkg_name" == "git" ]]; then
            warning "For Git, see: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
        fi
        error_exit "Prerequisite installation failed for $actual_pkg_name."
      fi
    done
  else
    info "All prerequisites (Git, Neovim) are already installed."
  fi

  # Final check after install attempts
  if ! command_exists git; then error_exit "Git is required but could not be installed/found. Please install Git manually."; fi
  if ! command_exists nvim; then error_exit "Neovim is required but could not be installed/found. Please install Neovim manually."; fi
}

# --- Main Logic ---
main() {
  info "Starting NvPak installation for Unix-like systems..."

  local os=""
  local pm=""
  local pm_update=""

  # OS and Package Manager Detection
  if [[ "$(uname)" == "Linux" ]]; then
    os="Linux"
    if command_exists apt-get; then
      pm="sudo apt-get install -y"
      pm_update="sudo apt-get update"
    elif command_exists yum; then
      pm="sudo yum install -y"
      pm_update="sudo yum update -y" # Often -y is good for yum update too
    elif command_exists dnf; then
      pm="sudo dnf install -y"
      pm_update="sudo dnf check-update" # dnf check-update doesn't need -y, it's not modifying
    elif command_exists pacman; then
      pm="sudo pacman -S --noconfirm" # For install, update is separate or part of -Syu
      pm_update="sudo pacman -Syu --noconfirm" # Full system upgrade
    elif grep -q "Android" /proc/version && command_exists pkg; then
      os="Android" # Termux
      pm="pkg install -y"
      pm_update="pkg update -y && pkg upgrade -y"
    else
      error_exit "Unsupported Linux distribution or package manager not found. Please install Git and Neovim manually and re-run."
    fi
  elif [[ "$(uname)" == "Darwin" ]]; then
    os="Mac"
    if command_exists brew; then
      pm="brew install"
      pm_update="brew update"
    else
      error_exit "Homebrew not found on macOS. Please install Homebrew (https://brew.sh/) and re-run."
    fi
  elif [[ -n "$WINDIR" ]] || [[ "$(uname -o 2>/dev/null)" == "Msys" ]] || [[ "$(uname -o 2>/dev/null)" == "Cygwin" ]]; then
    info "Detected a Windows-based Unix-like shell (e.g., Git Bash, WSL, Cygwin, Msys)."
    info "This script will attempt to check for Git and Neovim."
    info "For a native Windows experience, please use the 'install.ps1' script."
    if ! command_exists git || ! command_exists nvim; then
       warning "Git or Neovim might not be installed or not in PATH."
       warning "Please ensure Git and Neovim are installed and accessible in your PATH."
       # Do not error_exit here, let user try if they know what they are doing.
       # The Lua installer will perform more checks.
    fi
    # No standard package manager for these environments, so skip auto-install.
  else
    error_exit "Unsupported operating system: $(uname). This script supports Linux, macOS, and Unix-like shells on Windows."
  fi

  info "Detected OS: $os"
  if [[ -n "$pm" ]]; then # If a package manager was identified for auto-installation
    install_prerequisites "$os" "$pm" "$pm_update"
  else
    info "Skipping automatic prerequisite installation due to OS/environment."
    info "Please ensure Git and Neovim are installed and in your PATH."
    if ! command_exists git; then error_exit "Git is required. Please install it manually."; fi
    if ! command_exists nvim; then error_exit "Neovim (nvim) is required. Please install it manually."; fi
    success "Git and Neovim found."
  fi

  # Clone or update NvPak repository
  info "Setting up NvPak configuration directory: $NVIM_CONFIG_DIR"
  if [ -d "$NVIM_CONFIG_DIR/.git" ]; then
    info "NvPak directory already exists and is a git repository. Checking for updates..."
    ( # Subshell to avoid cd side effects
      cd "$NVIM_CONFIG_DIR" || error_exit "Could not cd into $NVIM_CONFIG_DIR"
      current_remote=$(git remote get-url origin 2>/dev/null)
      if [[ "$current_remote" == "$NVPAK_REPO_URL" ]]; then
        info "Pulling latest changes from NvPak repository ($NVPAK_REPO_URL)..."
        if git pull; then
          success "NvPak updated successfully."
        else
          warning "Failed to pull latest NvPak changes. Your configuration might be outdated or you have local changes."
          warning "Attempting to continue. If issues arise, consider a fresh clone after backing up."
        fi
      else
        warning "The existing directory $NVIM_CONFIG_DIR is a git repository, but not for NvPak."
        warning "Current remote: $current_remote"
        warning "Expected remote: $NVPAK_REPO_URL"
        error_exit "Please backup/move your existing Neovim config from $NVIM_CONFIG_DIR and re-run."
      fi
    )
  elif [ -d "$NVIM_CONFIG_DIR" ] && [ -z "$(ls -A "$NVIM_CONFIG_DIR")" ]; then
    info "$NVIM_CONFIG_DIR exists but is empty. Cloning NvPak..."
    if git clone --depth 1 "$NVPAK_REPO_URL" "$NVIM_CONFIG_DIR"; then
      success "NvPak cloned successfully to $NVIM_CONFIG_DIR."
    else
      error_exit "Failed to clone NvPak repository to $NVIM_CONFIG_DIR."
    fi
  elif [ -d "$NVIM_CONFIG_DIR" ]; then
     warning "$NVIM_CONFIG_DIR exists and is not empty, nor is it a NvPak git repository."
     error_exit "Please backup/move your existing Neovim config from $NVIM_CONFIG_DIR and re-run."
  else
    info "Cloning NvPak repository to $NVIM_CONFIG_DIR..."
    if git clone --depth 1 "$NVPAK_REPO_URL" "$NVIM_CONFIG_DIR"; then
      success "NvPak cloned successfully to $NVIM_CONFIG_DIR."
    else
      error_exit "Failed to clone NvPak repository to $NVIM_CONFIG_DIR."
    fi
  fi

  # Trigger Lua installer
  info "Launching Neovim to run NvPak Lua installer ($NVPAK_INSTALLER_LUA_MODULE)..."
  # We use -u $NVIM_CONFIG_DIR/init.lua to ensure it loads NvPak's init.lua,
  # which should then correctly set up package paths for the installer module.
  # The --headless ensures no UI pops up if not needed, but the Lua script can decide.
  # The Lua script itself should handle further user interaction.
  # The +qa is removed as the Lua script will handle exit or further steps.
  local nvim_cmd_args=(
    "--headless"
    "-u" "$NVIM_CONFIG_DIR/init.lua" # Ensure NvPak's init is loaded
    "-c" "lua require('$NVPAK_INSTALLER_LUA_MODULE').init()"
    # "+qa" # Lua script will manage quitting or further interaction
  )

  info "Executing: nvim ${nvim_cmd_args[*]}"
  if nvim "${nvim_cmd_args[@]}"; then
    success "NvPak Lua installer finished successfully."
    info "NvPak setup is complete. You can now start Neovim with 'nvim'."
    info "Further configuration or plugin installations might happen on the first interactive launch."
  else
    error_exit "NvPak Lua installer failed. Check Neovim output for errors."
  fi

  # The old messages about Nerd Fonts and running Neovim for plugins are now handled by the Lua installer.

  # --- Deploy nvpak CLI script ---
  info "Attempting to deploy 'nvpak' CLI script..."
  local nvpak_cli_source="$NVIM_CONFIG_DIR/scripts/nvpak.sh"
  if [ ! -f "$nvpak_cli_source" ]; then
    warning "'nvpak.sh' not found in NvPak scripts directory: $nvpak_cli_source"
    warning "Cannot deploy 'nvpak' CLI automatically."
  else
    local cli_installed_path=""
    # Try ~/.local/bin first
    local local_bin_dir="$HOME/.local/bin"
    if [ -d "$local_bin_dir" ]; then
      if [[ ":$PATH:" == *":$local_bin_dir:"* ]]; then
        info "Found '$local_bin_dir' in PATH. Attempting to install 'nvpak' there."
        if cp "$nvpak_cli_source" "$local_bin_dir/nvpak" && chmod +x "$local_bin_dir/nvpak"; then
          success "'nvpak' CLI script installed to $local_bin_dir/nvpak"
          cli_installed_path="$local_bin_dir/nvpak"
        else
          warning "Failed to copy 'nvpak.sh' to $local_bin_dir. Permissions?"
        fi
      else
        info "'$local_bin_dir' exists but does not seem to be in your PATH."
        info "You might need to add it to your PATH: export PATH=\"\$HOME/.local/bin:\$PATH\" (in .bashrc/.zshrc)"
      fi
    else
      info "'$HOME/.local/bin' not found."
    fi

    # If not installed in ~/.local/bin, try /usr/local/bin (might need sudo)
    if [ -z "$cli_installed_path" ]; then
      local usr_local_bin_dir="/usr/local/bin"
      if [ -w "$usr_local_bin_dir" ]; then # Check if writable directly
        info "Attempting to install 'nvpak' to $usr_local_bin_dir (writable)."
        if cp "$nvpak_cli_source" "$usr_local_bin_dir/nvpak" && chmod +x "$usr_local_bin_dir/nvpak"; then
          success "'nvpak' CLI script installed to $usr_local_bin_dir/nvpak"
          cli_installed_path="$usr_local_bin_dir/nvpak"
        else
          warning "Failed to copy 'nvpak.sh' to $usr_local_bin_dir even though it seemed writable."
        fi
      elif command_exists sudo && [ "$EUID" -ne 0 ]; then # Not root, but sudo exists
         info "'$usr_local_bin_dir' is not writable by current user."
         read -r -p "Do you want to try installing 'nvpak' to $usr_local_bin_dir using sudo? (y/N): " response
         if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            info "Attempting to install 'nvpak' to $usr_local_bin_dir using sudo..."
            if sudo cp "$nvpak_cli_source" "$usr_local_bin_dir/nvpak" && sudo chmod +x "$usr_local_bin_dir/nvpak"; then
                success "'nvpak' CLI script installed to $usr_local_bin_dir/nvpak using sudo."
                cli_installed_path="$usr_local_bin_dir/nvpak"
            else
                warning "Failed to install 'nvpak.sh' to $usr_local_bin_dir using sudo."
            fi
         else
            info "Skipped installing 'nvpak' to $usr_local_bin_dir via sudo."
         fi
      fi
    fi

    if [ -n "$cli_installed_path" ]; then
      info "The 'nvpak' command should now be available in new terminal sessions."
      info "If not, ensure '$cli_installed_path' is in a directory included in your PATH."
    else
      warning "Could not automatically install 'nvpak' CLI to a standard PATH directory."
      info "You can manually make it available by:"
      info "  1. Creating a symbolic link: sudo ln -s \"$nvpak_cli_source\" /usr/local/bin/nvpak"
      info "  2. Or copying it: sudo cp \"$nvpak_cli_source\" /usr/local/bin/nvpak && sudo chmod +x /usr/local/bin/nvpak"
      info "  3. Or adding the '$NVIM_CONFIG_DIR/scripts' directory to your PATH."
      info "     (e.g., export PATH=\"\$PATH:$NVIM_CONFIG_DIR/scripts\" in your .bashrc or .zshrc)"
    fi
  fi
  echo "" # Extra line for readability

  success "NvPak shell script part finished!"
  info "Please restart your terminal if new tools were installed by your package manager earlier (e.g., Neovim itself), or for 'nvpak' CLI to become available."
}

# --- Entry Point ---
main

exit 0
