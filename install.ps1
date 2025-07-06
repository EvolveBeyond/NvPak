#Requires -Version 5.1

<#
.SYNOPSIS
    Installs NvPak, a Neovim configuration, and its dependencies on Windows.
.DESCRIPTION
    This script automates the installation of Neovim, Git, Curl, Unzip, Ripgrep, Fd,
    and other necessary tools using Scoop package manager. It then clones or updates
    the NvPak configuration from GitHub.
.NOTES
    Author: Jules (AI Assistant)
    License: Apache 2.0 (Same as NvPak)
#>

# --- Configuration ---
$NvPakRepoUrl = "https://github.com/Pakrohk-DotFiles/NvPak.git"
$NvimConfigDir = "$env:LOCALAPPDATA\nvim"

# --- Helper Functions ---
function Print-Message($message, $color) {
    Write-Host $message -ForegroundColor $color
}

function Info($message) {
    Print-Message "INFO: $message" "Cyan"
}

function Success($message) {
    Print-Message "SUCCESS: $message" "Green"
}

function Warning($message) {
    Print-Message "WARNING: $message" "Yellow"
}

function Error-Exit($message) {
    Print-Message "ERROR: $message" "Red"
    exit 1
}

function Command-Exists($command) {
    return (Get-Command $command -ErrorAction SilentlyContinue) -ne $null
}

function Install-Scoop {
    Info "Scoop package manager not found."
    $confirmation = Read-Host "Do you want to install Scoop? (Required for automatic dependency installation) (y/N)"
    if ($confirmation -eq 'y') {
        Info "Installing Scoop..."
        try {
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            Invoke-RestMethod -Uri get.scoop.sh | Invoke-Expression
            Success "Scoop installed successfully."
            Info "Please open a new PowerShell terminal and re-run this script to continue with NvPak installation."
            Info "Scoop adds itself to your PATH, which requires a new terminal session to take effect."
            exit 0 # Exit so user can restart
        }
        catch {
            Error-Exit "Failed to install Scoop. Please install it manually from https://scoop.sh/ and re-run this script."
        }
    }
    else {
        Error-Exit "Scoop installation declined. Cannot proceed with automatic dependency installation."
    }
}

function Install-Package($packageName, [switch]$NoUpdate) {
    Info "Checking for $packageName..."
    if (-not (Command-Exists $packageName.Split(' ')[0])) { # Check for the command itself, not the scoop package name if different
        Info "Installing $packageName via Scoop..."
        try {
            if (-not $NoUpdate) {
                Info "Updating Scoop before installing $packageName..."
                scoop update $packageName -ErrorAction Stop
            }
            scoop install $packageName -ErrorAction Stop
            Success "$packageName installed successfully."
        }
        catch {
            Warning "Failed to install $packageName via Scoop. Please try installing it manually: 'scoop install $packageName'"
            # Optionally, make this an Error-Exit if the package is critical
        }
    }
    else {
        Info "$packageName is already installed."
    }
}

# --- Main Logic ---
function Main {
    Info "Starting NvPak installation for Windows..."

    # Check for Scoop
    if (-not (Command-Exists "scoop")) {
        Install-Scoop
    } else {
        Info "Scoop is installed."
        Info "Updating Scoop itself..."
        scoop update scoop # Update scoop itself first
    }

    # Install core dependencies using Scoop
    Info "Installing core dependencies (Git, Curl, Unzip, Neovim)..."
    Install-Package "git"
    Install-Package "curl"
    Install-Package "unzip" # 7zip provides unzip capabilities and is more common with scoop
    Install-Package "neovim"

    # Install additional tools
    Info "Installing additional tools (ripgrep, fd)..."
    Install-Package "ripgrep"
    Install-Package "fd"
    # Clipboard on Windows is generally handled by Neovim's integration with win32yank (often bundled or installed by LSP/plugins)
    # Or users can install win32yank via scoop: scoop install win32yank

    # Pynvim (optional, for Python devs)
    if (Command-Exists "pip3") {
        Info "Checking for pynvim (Python 3)..."
        $pynvim_check = python3 -m pynvim -c "import sys; sys.exit(0)" 2>&1
        if ($LASTEXITCODE -ne 0) {
            Info "pynvim (Python 3) not found. Installing..."
            pip3 install --user pynvim
            if ($LASTEXITCODE -ne 0) {
                Warning "Failed to install pynvim with pip3. Python integration might not work."
            } else {
                Success "pynvim installed."
            }
        } else {
            Info "pynvim (Python 3) is already installed."
        }
    }
    elseif (Command-Exists "pip") {
        Info "Checking for pynvim (Python)..."
        $pynvim_check = python -m pynvim -c "import sys; sys.exit(0)" 2>&1
        if ($LASTEXITCODE -ne 0) {
            Info "pynvim (Python) not found. Installing..."
            pip install --user pynvim
            if ($LASTEXITCODE -ne 0) {
                Warning "Failed to install pynvim with pip. Python integration might not work."
            } else {
                Success "pynvim installed."
            }
        } else {
            Info "pynvim (Python) is already installed."
        }
    }
    else {
        Warning "pip/pip3 not found. Cannot install pynvim automatically. If you are a Python developer, please install it manually."
    }

    # Clone or update NvPak repository
    Info "Setting up NvPak configuration directory: $NvimConfigDir"
    if (Test-Path $NvimConfigDir) {
        Info "NvPak directory already exists. Checking for updates..."
        Push-Location $NvimConfigDir
        if (Test-Path ".git") {
            $currentRemote = git remote get-url origin
            if ($currentRemote -eq $NvPakRepoUrl) {
                Info "Pulling latest changes from NvPak repository..."
                git pull
                if ($LASTEXITCODE -ne 0) {
                    Warning "Failed to pull latest changes. Your configuration might be outdated."
                }
            }
            else {
                Warning "The existing directory $NvimConfigDir is a git repository, but not for NvPak ($currentRemote)."
                Warning "Please move or backup your existing Neovim configuration and re-run the script."
                Error-Exit "Installation aborted due to existing non-NvPak git repository."
            }
        }
        else {
            Warning "$NvimConfigDir exists but is not a git repository. It might be an old NvPak install or a custom config."
            Error-Exit "Please backup/move your existing Neovim config from $NvimConfigDir and re-run."
        }
        Pop-Location
    }
    else {
        Info "Cloning NvPak repository to $NvimConfigDir..."
        git clone --depth 1 $NvPakRepoUrl $NvimConfigDir
        if ($LASTEXITCODE -ne 0) {
            Error-Exit "Failed to clone NvPak repository."
        }
    }

    # Nerd Fonts Installation (Guidance)
    Info "--- Nerd Fonts ---"
    Info "For the best visual experience, please install a Nerd Font."
    Info "You can find them at: https://www.nerdfonts.com/"
    Info "After installation, set it as your terminal font (e.g., in Windows Terminal settings)."
    Write-Host "" # Newline

    # Initial Neovim run for plugin installation
    Info "Running Neovim for the first time to install plugins via rocks.nvim..."
    Info "This might take a few moments. Please wait for Neovim to fully load and install plugins."
    Info "If prompted by rocks.nvim, confirm any installations."

    if (Command-Exists "nvim") {
        Start-Process nvim -ArgumentList "--headless", "+qa" -Wait
        Info "Neovim headless setup attempt complete. Starting Neovim..."
        Info "Please close Neovim after plugins are installed (you might see messages from rocks.nvim)."
        Start-Process nvim
    }
    else {
        Error-Exit "Neovim command (nvim) not found even after installation attempt. Please check your PATH."
    }

    Success "NvPak installation script finished!"
    Info "Please restart your terminal or source your shell configuration if you installed new tools."
    Info "Open Neovim with 'nvim'."
}

# --- Entry Point ---
Main

exit 0
