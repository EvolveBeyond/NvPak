#Requires -Version 5.1

<#
.SYNOPSIS
    Installs NvPak, a Neovim configuration, on Windows.
.DESCRIPTION
    This script ensures Git and Neovim are installed (using Scoop if available),
    clones or updates the NvPak configuration from GitHub, and then triggers
    the Lua-based NvPak installer.
.NOTES
    Author: Jules (AI Assistant) & Pakrohk
    License: Apache 2.0 (Same as NvPak)
#>

# --- Configuration ---
$NvPakRepoUrl = "https://github.com/Pakrohk-DotFiles/NvPak.git"
$NvimConfigDir = "$env:LOCALAPPDATA\nvim" # Standard Neovim config directory on Windows
$NvPakInstallerLuaModule = "nvpak.core.installer" # Lua module to run, e.g., require('nvpak.core.installer').init()

# --- Helper Functions ---
function Print-Message($message, $color) {
    Write-Host $message -ForegroundColor $color
}

function Info($message) { Print-Message "INFO: $message" "Cyan" }
function Success($message) { Print-Message "SUCCESS: $message" "Green" }
function Warning($message) { Print-Message "WARNING: $message" "Yellow" }
function Error-Exit($message) {
    Print-Message "ERROR: $message" "Red"
    exit 1
}

function Command-Exists($command) {
    return (Get-Command $command -ErrorAction SilentlyContinue) -ne $null
}

# --- Prerequisite Installation ---
function Install-Scoop {
    Info "Scoop package manager not found."
    $confirmation = Read-Host "Do you want to install Scoop? (Recommended for automatic Git/Neovim installation) (y/N)"
    if ($confirmation -eq 'y') {
        Info "Installing Scoop..."
        try {
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            Invoke-RestMethod -Uri get.scoop.sh | Invoke-Expression
            Success "Scoop installed successfully."
            Info "IMPORTANT: Scoop has been installed and added to your PATH."
            Info "Please OPEN A NEW PowerShell terminal and RE-RUN this script to continue."
            exit 0 # Exit so user can restart in a new shell where scoop is in PATH
        }
        catch {
            Error-Exit "Failed to install Scoop. Please install it manually from https://scoop.sh/ and ensure Git and Neovim are also installed, then re-run this script."
        }
    }
    else {
        Warning "Scoop installation declined. Proceeding with checks for existing Git/Neovim."
        Warning "If Git or Neovim are not found, you will need to install them manually."
    }
}

function Install-Prerequisites {
    $scoopAvailable = Command-Exists "scoop"
    if (-not $scoopAvailable) {
        Install-Scoop # This might exit if user installs scoop
        $scoopAvailable = Command-Exists "scoop" # Re-check in case user declined but scoop was already there somehow
    }

    if ($scoopAvailable) {
        Info "Scoop is available. Updating Scoop buckets..."
        scoop update # Update all buckets
    } else {
        Info "Scoop not found or installation declined. Will check for manual installations of Git and Neovim."
    }

    $packagesToInstall = @()
    # Check for Git
    Info "Checking for Git..."
    if (-not (Command-Exists "git")) {
        Info "Git not found."
        if ($scoopAvailable) { $packagesToInstall += "git" }
        else { Error-Exit "Git not found. Please install Git manually (e.g., from https://git-scm.com/download/win) and re-run this script." }
    } else {
        Info "Git is installed."
    }

    # Check for Neovim
    Info "Checking for Neovim (nvim)..."
    if (-not (Command-Exists "nvim")) {
        Info "Neovim (nvim) not found."
        if ($scoopAvailable) { $packagesToInstall += "neovim" }
        else { Error-Exit "Neovim (nvim) not found. Please install Neovim manually (e.g., from https://neovim.io/) and re-run this script." }
    } else {
        Info "Neovim is installed."
    }

    if ($packagesToInstall.Count -gt 0 -and $scoopAvailable) {
        Info "Attempting to install missing prerequisites via Scoop: $($packagesToInstall -join ', ')"
        foreach ($pkg in $packagesToInstall) {
            Info "Installing $pkg via Scoop..."
            try {
                scoop install $pkg -ErrorAction Stop
                Success "$pkg installed successfully via Scoop."
            }
            catch {
                Error-Exit "Failed to install $pkg via Scoop. Please install it manually and re-run this script. Scoop error: $($_.Exception.Message)"
            }
        }
    } elseif ($packagesToInstall.Count -gt 0 -and (-not $scoopAvailable)) {
        # This case should have been caught by earlier Error-Exits if Scoop was declined and tools were missing.
        Error-Exit "Prerequisites missing and Scoop is not available for automatic installation. Please install manually."
    }
    else {
        Info "All prerequisites (Git, Neovim) are already installed or were installed."
    }

    # Final check
    if (-not (Command-Exists "git")) { Error-Exit "Git is required but could not be installed/found. Please install Git manually." }
    if (-not (Command-Exists "nvim")) { Error-Exit "Neovim (nvim) is required but could not be installed/found. Please install Neovim manually." }
    Success "Git and Neovim are available."
}


# --- Main Logic ---
function Main {
    Info "Starting NvPak installation for Windows..."

    Install-Prerequisites

    # Clone or update NvPak repository
    Info "Setting up NvPak configuration directory: $NvimConfigDir"
    $gitDir = Join-Path $NvimConfigDir ".git"

    if (Test-Path $gitDir) {
        Info "NvPak directory already exists and is a git repository. Checking for updates..."
        Push-Location $NvimConfigDir
        try {
            $currentRemote = git remote get-url origin
            if ($currentRemote -match [regex]::Escape($NvPakRepoUrl)) { # Use -match for flexibility (http vs https)
                Info "Pulling latest changes from NvPak repository ($NvPakRepoUrl)..."
                git pull
                if ($LASTEXITCODE -ne 0) {
                    Warning "Failed to pull latest NvPak changes. Your configuration might be outdated or you have local changes."
                    Warning "Attempting to continue. If issues arise, consider a fresh clone after backing up."
                } else {
                    Success "NvPak updated successfully."
                }
            }
            else {
                Warning "The existing directory $NvimConfigDir is a git repository, but not for NvPak."
                Warning "Current remote: $currentRemote"
                Warning "Expected remote: $NvPakRepoUrl"
                Error-Exit "Please backup/move your existing Neovim config from $NvimConfigDir and re-run."
            }
        }
        catch {
            Error-Exit "Error while checking git repository in $NvimConfigDir: $($_.Exception.Message)"
        }
        finally {
            Pop-Location
        }
    }
    elseif (Test-Path $NvimConfigDir -PathType Container) {
        # Directory exists but not a .git repo, or .git is not a directory
        # Check if it's empty
        if ((Get-ChildItem -Path $NvimConfigDir -Force | Measure-Object).Count -eq 0) {
            Info "$NvimConfigDir exists but is empty. Cloning NvPak..."
            git clone --depth 1 $NvPakRepoUrl $NvimConfigDir
            if ($LASTEXITCODE -ne 0) { Error-Exit "Failed to clone NvPak repository to $NvimConfigDir." }
            Success "NvPak cloned successfully to $NvimConfigDir."
        } else {
            Warning "$NvimConfigDir exists, is not empty, and is not a NvPak git repository."
            Error-Exit "Please backup/move your existing Neovim config from $NvimConfigDir and re-run."
        }
    }
    else { # Directory does not exist
        Info "Cloning NvPak repository to $NvimConfigDir..."
        git clone --depth 1 $NvPakRepoUrl $NvimConfigDir
        if ($LASTEXITCODE -ne 0) { Error-Exit "Failed to clone NvPak repository to $NvimConfigDir." }
        Success "NvPak cloned successfully to $NvimConfigDir."
    }

    # Trigger Lua installer
    Info "Launching Neovim to run NvPak Lua installer ($NvPakInstallerLuaModule)..."
    $nvimPath = Get-Command nvim | Select-Object -ExpandProperty Source
    $initLuaPath = Join-Path $NvimConfigDir "init.lua"

    $arguments = @(
        "--headless"
        "-u", "`"$initLuaPath`"" # Ensure NvPak's init.lua is loaded
        "-c", "`"lua require('$NvPakInstallerLuaModule').init()`""
    )

    Info "Executing: $nvimPath $arguments"
    # Start-Process $nvimPath -ArgumentList $arguments -Wait -NoNewWindow # Using -NoNewWindow can be good for seeing output
    # However, for scripts that might need interactive prompts from Lua (less likely for pure headless)
    # or if Neovim itself has issues with -NoNewWindow in some contexts, running directly might be better.
    # Let's try invoking directly, which is more common for CLI tools.
    & $nvimPath $arguments

    if ($LASTEXITCODE -eq 0) {
        Success "NvPak Lua installer finished successfully."
        Info "NvPak setup is complete. You can now start Neovim with 'nvim'."
        Info "Further configuration or plugin installations might happen on the first interactive launch."
    } else {
        Error-Exit "NvPak Lua installer failed. Exit code: $LASTEXITCODE. Check Neovim output for errors (if any was printed)."
    }

    # --- Deploy nvpak.ps1 CLI script ---
    Info "Attempting to deploy 'nvpak.ps1' CLI script..."
    $nvpakCliSource = Join-Path $NvimConfigDir "scripts\nvpak.ps1" # Note backslash for PowerShell
    $nvpakCliDestDir = Join-Path $env:LOCALAPPDATA "NvPak\bin"
    $nvpakCliDestFile = Join-Path $nvpakCliDestDir "nvpak.ps1"

    if (-not (Test-Path $nvpakCliSource)) {
        Warning "'nvpak.ps1' not found in NvPak scripts directory: $nvpakCliSource"
        Warning "Cannot deploy 'nvpak' CLI automatically."
    }
    else {
        try {
            if (-not (Test-Path $nvpakCliDestDir)) {
                New-Item -ItemType Directory -Path $nvpakCliDestDir -Force -ErrorAction Stop | Out-Null
                Info "Created directory: $nvpakCliDestDir"
            }
            Copy-Item -Path $nvpakCliSource -Destination $nvpakCliDestFile -Force -ErrorAction Stop
            Success "'nvpak.ps1' CLI script copied to: $nvpakCliDestFile"

            # Check if the destination directory is in PATH
            $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
            if ($currentPath -notlike "*$($nvpakCliDestDir -replace '\\', '\\')*") { # Escape backslashes for regex like comparison
                Warning "The directory '$nvpakCliDestDir' is not in your User PATH."
                Info "To use the 'nvpak' command directly in PowerShell, you need to add this directory to your PATH."
                Info "You can do this by running the following commands in PowerShell (consider running as Administrator if you want to set System PATH):"
                Info "---"
                Info "  `$CurrentUserPath = [Environment]::GetEnvironmentVariable('Path', 'User')`"
                Info "  `$NewPath = `$CurrentUserPath;$nvpakCliDestDir`" # Or `$NewPath = "$nvpakCliDestDir;$CurrentUserPath"` to prepend
                Info "  `[Environment]::SetEnvironmentVariable('Path', `$NewPath, 'User')`"
                Info "  `# For System PATH (requires Admin): [Environment]::SetEnvironmentVariable('Path', `$NewPath, 'Machine')`"
                Info "---"
                Info "After updating your PATH, you MUST open a new PowerShell window for the changes to take effect."
            } else {
                Success "'$nvpakCliDestDir' seems to be in your PATH. 'nvpak' command should be available in new PowerShell sessions."
            }
        }
        catch {
            Warning "Failed to deploy 'nvpak.ps1' CLI script. Error: $($_.Exception.Message)"
            Info "You can manually copy '$nvpakCliSource' to a directory in your PATH."
        }
    }
    Write-Host "" # Extra line for readability

    Success "NvPak PowerShell script part finished!"
    Info "If Scoop installed or updated tools, or if you modified your PATH for 'nvpak' CLI, a new PowerShell session is likely needed."
}

# --- Entry Point ---
Main

exit 0
