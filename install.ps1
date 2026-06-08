<#
.SYNOPSIS
    NvPak Professional Installer for Windows
#>

$ErrorActionPreference = 'Stop'

# --- UI Helpers ---
function Show-Header {
    Clear-Host
    Write-Host @"
  _   _      _____
 | \ | |    |  __ \
 |  \| |  __| |__) |_ _  | |
 | . \` | / _\` |  ___/ _\` | |/ /
 | |\  || (_| | |  | (_| |   <
 |_| \_| \__,_|_|   \__,_|_|\_\
"@ -ForegroundColor Magenta
    Write-Host "`nWelcome to the NvPak professional installer." -ForegroundColor Cyan
}

function Info ($msg) { Write-Host "info  $msg" -ForegroundColor Blue }
function Success ($msg) { Write-Host "success $msg" -ForegroundColor Green }
function Warn ($msg) { Write-Host "warn  $msg" -ForegroundColor Yellow }
function Error-Exit ($msg) { Write-Host "error $msg" -ForegroundColor Red; exit 1 }

# --- Constants ---
$RepoUrl = "https://github.com/Pakrohk-DotFiles/NvPak.git"
$ConfigDir = "$env:LOCALAPPDATA\nvim"

# --- Main Logic ---
Show-Header

# Check for Scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Info "Installing Scoop package manager..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri get.scoop.sh | Invoke-Expression
}

Info "Installing/Updating dependencies..."
scoop install git neovim ripgrep fd 7zip win32yank -s || Info "Some packages might already be installed."

if (Test-Path $ConfigDir) {
    if (Test-Path "$ConfigDir\.git") {
        Info "Updating NvPak..."
        Set-Location $ConfigDir
        git pull
    } else {
        Warn "Existing config found. Backing up..."
        Rename-Item -Path $ConfigDir -NewName "$ConfigDir.bak.$([DateTimeOffset]::Now.ToUnixTimeSeconds())"
        git clone --depth 1 $RepoUrl $ConfigDir
    }
} else {
    Info "Cloning NvPak..."
    git clone --depth 1 $RepoUrl $ConfigDir
}

Info "Bootstrapping plugins..."
Start-Process nvim -ArgumentList "--headless", "+Rocks sync", "+qa" -Wait -NoNewWindow

Success "NvPak has been installed successfully!"
Info "Run 'nvim' to start."
Info "Ensure you have a Nerd Font installed for proper icons."
