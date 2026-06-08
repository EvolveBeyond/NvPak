#Requires -Version 5.1
<#
.SYNOPSIS
    NvPak CLI - Command Line Interface for managing NvPak and its plugins on Windows.
.DESCRIPTION
    Provides commands to install, uninstall, update plugins, and fetch NvPak updates.
    Supports aliases defined in a configuration file.
.NOTES
    Author: Jules (AI Assistant) & Pakrohk
#>

# --- Configuration ---
$NvPakConfigDir = Join-Path $env:LOCALAPPDATA "nvpak" # For aliases, etc.
$NvimConfigDir = Join-Path $env:LOCALAPPDATA "nvim"   # NvPak's installation directory
$AliasFile = Join-Path $NvPakConfigDir "aliases.conf"
$InstallerModule = "nvpak.core.installer" # The Lua module containing CLI functions

# --- Helper Functions ---
function Print-Message($message, $color, $WriteError = $false) {
    if ($WriteError) {
        Write-Error $message # Errors go to stderr stream
    } else {
        Write-Host $message -ForegroundColor $color
    }
}

function Info($message) { Print-Message $message "Cyan" }
function Success($message) { Print-Message $message "Green" }
function Warning($message) { Print-Message $message "Yellow" }
function Error-Exit($message) {
    Print-Message $message "Red" -WriteError $true
    exit 1
}

function Command-Exists($command) {
    return (Get-Command $command -ErrorAction SilentlyContinue) -ne $null
}

# Ensure Neovim is installed
if (-not (Command-Exists "nvim")) {
    Error-Exit "Neovim (nvim.exe) is not installed or not in your PATH. NvPak CLI requires Neovim."
}

# Ensure NvPak config directory exists
if (-not (Test-Path (Join-Path $NvimConfigDir "init.lua"))) {
    Error-Exit "NvPak configuration (init.lua) not found at $NvimConfigDir. Please install NvPak first."
}

# --- Alias Resolution ---
function Resolve-AliasCmd {
    param(
        [string]$CommandAlias
    )
    if (Test-Path $AliasFile) {
        try {
            $aliases = Get-Content $AliasFile | Where-Object { $_ -notmatch '^\s*#' -and $_ -match '.=' } | ConvertFrom-StringData -Delimiter '='
            if ($aliases.$CommandAlias) {
                return $aliases.$CommandAlias.Trim()
            }
        }
        catch {
            Warning "Could not parse alias file at $AliasFile. Error: $($_.Exception.Message)"
        }
    }
    return $CommandAlias # Return original if not found or file doesn't exist/parse
}

# --- Neovim Command Execution ---
function Run-NvimLuaCommand {
    param(
        [string]$LuaFunctionName,
        [string[]]$Arguments
    )

    $luaArgsString = ""
    if ($Arguments) {
        $escapedArgs = $Arguments | ForEach-Object { "'" + ($_ -replace "'", "''") + "'" } # Escape single quotes for Lua
        $luaArgsString = $escapedArgs -join ", "
    }

    $luaCommand = "require('$InstallerModule').$LuaFunctionName($luaArgsString)"
    Info "Executing Lua: $luaCommand"

    $nvimPath = (Get-Command nvim).Source
    $initLuaPath = Join-Path $NvimConfigDir "init.lua"

    $nvimArgs = @(
        "--headless"
        "-u", "`"$initLuaPath`"" # Ensure NvPak's init.lua is loaded
        "-c", "lua $luaCommand"
        # Similar to bash, ensure messages are flushed and nvim exits.
        # PowerShell's Start-Process or direct call might behave differently regarding console output.
        # Using direct call `&` seems more appropriate for CLI tools.
        "-c", "lua vim.cmd('redraw') vim.cmd('sleep 100m') if vim.v.headless == 1 and vim.fn.argc() == 0 then vim.cmd('qall!') end"
    )

    try {
        & $nvimPath $nvimArgs
        # $LASTEXITCODE should be set by the direct call.
        if ($LASTEXITCODE -ne 0) {
            Warning "Neovim command execution for '$LuaFunctionName' finished with exit code $LASTEXITCODE."
            # Further error details would ideally come from the Lua script's output.
        }
    }
    catch {
        Error-Exit "Failed to start Neovim process for '$LuaFunctionName'. Error: $($_.Exception.Message)"
    }
}

# --- Main CLI Logic ---
if ($args.Count -eq 0) {
    Info "Usage: nvpak <command> [arguments]"
    Info "Available commands (pre-alias resolution): install, uninstall, update, upgrade, fetch, help"
    Info "Run 'nvpak help' for more details."
    exit 0
}

$actionAlias = $args[0]
$remainingArgs = $args[1..($args.Count - 1)]

$action = Resolve-AliasCmd -CommandAlias $actionAlias

switch ($action) {
    "install" {
        if ($remainingArgs.Count -lt 1) { Error-Exit "Usage: nvpak install <plugin-spec>" }
        Info "Action: Install plugin '$($remainingArgs[0])'"
        Run-NvimLuaCommand "cli_install_package" $remainingArgs[0]
    }
    "uninstall" {
        if ($remainingArgs.Count -lt 1) { Error-Exit "Usage: nvpak uninstall <plugin-name>" }
        Info "Action: Uninstall plugin '$($remainingArgs[0])'"
        Run-NvimLuaCommand "cli_uninstall_package" $remainingArgs[0]
    }
    "update" {
        if ($remainingArgs.Count -eq 0) {
            Info "Action: Update all plugins"
            Run-NvimLuaCommand "cli_upgrade_all_packages" @()
        } else {
            Info "Action: Update plugin '$($remainingArgs[0])'"
            Run-NvimLuaCommand "cli_update_package" $remainingArgs[0]
        }
    }
    "upgrade" {
        Info "Action: Upgrade all plugins"
        Run-NvimLuaCommand "cli_upgrade_all_packages" @()
    }
    "refresh" {
        Info "Action: Refresh plugin list and sync"
        Run-NvimLuaCommand "cli_refresh_plugins" @()
    }
    "fetch" {
        Info "Action: Fetch NvPak updates (git pull)"
        Run-NvimLuaCommand "cli_fetch_nvpak" @()
    }
    "help" {
        Write-Host "NvPak CLI Help:"
        Write-Host "-----------------"
        Write-Host "Manages NvPak configuration and plugins from the command line."
        Write-Host ""
        Write-Host "Usage: nvpak <command> [arguments]"
        Write-Host ""
        Write-Host "Commands:"
        Write-Host "  install <plugin-spec>   Install a new plugin (e.g., 'user/repo')."
        Write-Host "  uninstall <plugin-name> Uninstall a plugin."
        Write-Host "  update [plugin-name]    Update a specific plugin or all plugins if no name is given."
        Write-Host "  upgrade                 Update all installed plugins."
        Write-Host "  refresh                 Synchronize plugins with the configuration (use after manual config changes)."
        Write-Host "  fetch                   Fetch the latest updates for NvPak itself from its repository."
        Write-Host "  help                    Show this help message."
        Write-Host ""
        Write-Host "Aliases can be defined in: $AliasFile"
        Write-Host "Format: alias_name=command_name (e.g., in=install)"
    }
    default {
        Error-Exit "Unknown command or alias: '$actionAlias' (resolved to '$action'). Run 'nvpak help'."
    }
}

exit 0
