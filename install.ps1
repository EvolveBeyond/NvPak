# NvPak Professional Installer (Windows Zen Edition)
$ErrorActionPreference = 'Stop'

function Confirm ($msg) {
    $choice = Read-Host "question $msg [y/N]"
    return $choice -eq 'y'
}

Clear-Host
Write-Host "NvPak Professional Installer (Zen Edition)`n" -ForegroundColor Magenta

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    if (Confirm "Scoop not found. Install it?") {
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Invoke-RestMethod -Uri get.scoop.sh | Invoke-Expression
    } else {
        Write-Host "warn  Skipping Scoop. Ensure dependencies are installed manually." -ForegroundColor Yellow
    }
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "info  Installing dependencies via Scoop..." -ForegroundColor Blue
    scoop install git neovim ripgrep fd 7zip win32yank -s || Write-Host "info  Some packages already present." -ForegroundColor Blue
}

$ConfigDir = "$env:LOCALAPPDATA\nvim"
$Repo = "https://github.com/Pakrohk-DotFiles/NvPak.git"

if (Test-Path $ConfigDir) {
    if (Test-Path "$ConfigDir\.git") {
        Write-Host "info  Updating NvPak..." -ForegroundColor Blue
        git -C $ConfigDir pull
    } else {
        if (Confirm "Non-git directory found at $ConfigDir. Backup and re-clone?") {
            Rename-Item $ConfigDir "$ConfigDir.bak.$([DateTimeOffset]::Now.ToUnixTimeSeconds())"
            git clone --depth 1 $Repo $ConfigDir
        }
    }
} else {
    Write-Host "info  Cloning NvPak..." -ForegroundColor Blue
    git clone --depth 1 $Repo $ConfigDir
}

Write-Host "info  Bootstrapping..." -ForegroundColor Blue
Start-Process nvim -ArgumentList "--headless", "+Rocks sync", "+qa" -Wait -NoNewWindow

Write-Host "success NvPak installation complete!" -ForegroundColor Green
