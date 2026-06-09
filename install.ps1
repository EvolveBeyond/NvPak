# NvPak Professional Installer (Windows)

$ErrorActionPreference = 'Stop'

function Info ($msg) { Write-Host "info  $msg" -ForegroundColor Blue }
function Success ($msg) { Write-Host "success $msg" -ForegroundColor Green }
function Warn ($msg) { Write-Host "warn  $msg" -ForegroundColor Yellow }

Clear-Host
Write-Host "NvPak Professional Installer`n" -ForegroundColor Magenta

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Info "Installing Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri get.scoop.sh | Invoke-Expression
}

Info "Installing dependencies..."
scoop install git neovim ripgrep fd 7zip win32yank -s || Info "Continuing..."

$ConfigDir = "$env:LOCALAPPDATA\nvim"
$Repo = "https://github.com/Pakrohk-DotFiles/NvPak.git"

if (Test-Path $ConfigDir) {
    if (Test-Path "$ConfigDir\.git") {
        Info "Updating NvPak..."
        git -C $ConfigDir pull
    } else {
        Warn "Backing up existing config..."
        Rename-Item $ConfigDir "$ConfigDir.bak.$([DateTimeOffset]::Now.ToUnixTimeSeconds())"
        git clone --depth 1 $Repo $ConfigDir
    }
} else {
    Info "Cloning NvPak..."
    git clone --depth 1 $Repo $ConfigDir
}

Info "Bootstrapping plugins..."
Start-Process nvim -ArgumentList "--headless", "+Rocks sync", "+qa" -Wait -NoNewWindow

Success "Done! Run 'nvim' to start."
