#!/usr/bin/env bash

# NvPak CLI - Command Line Interface for managing NvPak and its plugins.

# --- Configuration ---
# Attempt to use XDG_CONFIG_HOME, fallback to ~/.config
NVPAK_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvpak"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim" # NvPak's installation directory
ALIAS_FILE="$NVPAK_CONFIG_DIR/aliases.conf"
INSTALLER_MODULE="nvpak.core.installer" # The Lua module containing CLI functions

# --- Helper Functions ---
print_message() {
  local color_code="$1"
  local message="$2"
  echo -e "\033[${color_code}m${message}\033[0m"
}

info() { print_message "34" "INFO: $1"; }
success() { print_message "32" "SUCCESS: $1"; }
warning() { print_message "33" "WARNING: $1"; }
error_exit() {
  print_message "31" "ERROR: $1" >&2
  exit 1
}

command_exists() {
  command -v "$1" &>/dev/null
}

# Ensure Neovim is installed
if ! command_exists nvim; then
  error_exit "Neovim (nvim) is not installed or not in your PATH. NvPak CLI requires Neovim."
fi

# Ensure NvPak config directory exists (implies NvPak might be installed)
if [ ! -d "$NVIM_CONFIG_DIR" ] || [ ! -f "$NVIM_CONFIG_DIR/init.lua" ]; then
  error_exit "NvPak configuration directory not found at $NVIM_CONFIG_DIR. Please install NvPak first."
fi

# --- Alias Resolution ---
resolve_alias() {
  local cmd_alias="$1"
  if [ -f "$ALIAS_FILE" ]; then
    # Read aliases, ignore comments and empty lines
    # Format: alias_name=command_name
    local resolved_cmd
    resolved_cmd=$(grep -E "^\s*${cmd_alias}\s*=" "$ALIAS_FILE" | sed -E 's/^\s*[^=]+=\s*//' | tr -d '[:space:]')
    if [ -n "$resolved_cmd" ]; then
      echo "$resolved_cmd"
      return
    fi
  fi
  echo "$cmd_alias" # Return original if not found or file doesn't exist
}

# --- Neovim Command Execution ---
# Executes a Lua function within NvPak's Neovim environment.
# $1: The Lua function to call (e.g., "cli_install_package")
# $2+: Arguments for the Lua function, each will be passed as a string.
run_nvim_lua_command() {
  local lua_function_name="$1"
  shift # Remove function name from arguments list

  local lua_args_string=""
  local arg
  for arg in "$@"; do
    # Escape single quotes for Lua string literal
    local escaped_arg=$(echo "$arg" | sed "s/'/'\\\\''/g")
    if [ -z "$lua_args_string" ]; then
      lua_args_string="'$escaped_arg'"
    else
      lua_args_string="$lua_args_string, '$escaped_arg'"
    fi
  done

  local lua_command="require('$INSTALLER_MODULE').$lua_function_name($lua_args_string)"
  info "Executing Lua: $lua_command"

  # Using -u to load NvPak's init.lua ensures its environment (package paths etc.) is set up.
  # --headless ensures no UI.
  # We might not need -c "qall!" if the Lua functions handle exiting or if Neovim exits naturally.
  # For interactive CLI commands that print output, Neovim needs to stay open long enough.
  # The Lua functions should print to stdout/stderr for the CLI.
  if nvim --headless -u "$NVIM_CONFIG_DIR/init.lua" -c "lua $lua_command" -c "lua vim.cmd('redraw') vim.cmd('sleep 100m') if vim.v.headless == 1 and vim.fn.argc() == 0 then vim.cmd('qall!') end"; then
    # The sleep and redraw are attempts to ensure messages are flushed before nvim quits.
    # The conditional qall! is to make sure it quits if truly headless and no other files were opened.
    # This part might need refinement based on how Lua functions signal completion/output.
    # For functions like 'fetch' that use jobstart, Neovim must remain running until the job completes.
    # The Lua function itself should manage this, potentially by not exiting immediately if a job is running.
    : # Success, Lua script might have printed its own success/error.
  else
    error_exit "Neovim command execution failed for '$lua_function_name'."
  fi
}

# --- Main CLI Logic ---
if [ "$#" -eq 0 ]; then
  # TODO: Implement a proper help / usage message
  info "Usage: nvpak <command> [arguments]"
  info "Available commands (pre-alias resolution): install, uninstall, update, upgrade, fetch, help"
  info "Run 'nvpak help' for more details."
  exit 0
fi

ACTION_ALIAS="$1"
shift # Remove action from arguments

ACTION=$(resolve_alias "$ACTION_ALIAS")

case "$ACTION" in
  install)
    if [ "$#" -lt 1 ]; then error_exit "Usage: nvpak install <plugin-spec>"; fi
    info "Action: Install plugin '$1'"
    run_nvim_lua_command "cli_install_package" "$1"
    ;;
  uninstall)
    if [ "$#" -lt 1 ]; then error_exit "Usage: nvpak uninstall <plugin-name>"; fi
    info "Action: Uninstall plugin '$1'"
    run_nvim_lua_command "cli_uninstall_package" "$1"
    ;;
  update)
    # nvpak update (all) or nvpak update <plugin-name>
    if [ "$#" -eq 0 ]; then
      info "Action: Update all plugins"
      run_nvim_lua_command "cli_upgrade_all_packages" # Assuming upgrade_all_packages is the function for all
    else
      info "Action: Update plugin '$1'"
      run_nvim_lua_command "cli_update_package" "$1"
    fi
    ;;
  upgrade)
    info "Action: Upgrade all plugins"
    run_nvim_lua_command "cli_upgrade_all_packages"
    ;;
  refresh)
    info "Action: Refresh plugin list and sync"
    run_nvim_lua_command "cli_refresh_plugins"
    ;;
  fetch)
    info "Action: Fetch NvPak updates (git pull)"
    run_nvim_lua_command "cli_fetch_nvpak"
    ;;
  help)
    # TODO: More detailed help message
    echo "NvPak CLI Help:"
    echo "-----------------"
    echo "Manages NvPak configuration and plugins from the command line."
    echo ""
    echo "Usage: nvpak <command> [arguments]"
    echo ""
    echo "Commands:"
    echo "  install <plugin-spec>   Install a new plugin (e.g., 'user/repo')."
    echo "  uninstall <plugin-name> Uninstall a plugin."
    echo "  update [plugin-name]    Update a specific plugin or all plugins if no name is given."
    echo "  upgrade                 Update all installed plugins."
    echo "  refresh                 Synchronize plugins with the configuration (use after manual config changes)."
    echo "  fetch                   Fetch the latest updates for NvPak itself from its repository."
    echo "  help                    Show this help message."
    echo ""
    echo "Aliases can be defined in: $ALIAS_FILE"
    echo "Format: alias_name=command_name (e.g., in=install)"
    ;;
  *)
    error_exit "Unknown command or alias: '$ACTION_ALIAS' (resolved to '$ACTION'). Run 'nvpak help'."
    ;;
esac

exit 0
