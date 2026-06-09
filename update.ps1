# NvPak Smart Update Tool (Windows)
$ErrorActionPreference = 'Stop'

function Confirm ($msg) {
    $choice = Read-Host "question $msg [y/N]"
    return $choice -eq 'y'
}

Clear-Host
Write-Host "NvPak Smart Update Tool`n" -ForegroundColor Magenta

$ConfigDir = "$env:LOCALAPPDATA\nvim"

if (-not (Test-Path "$ConfigDir\.git")) {
    Write-Host "error $ConfigDir is not a git repository." -ForegroundColor Red
    exit 1
}

Set-Location $ConfigDir

Write-Host "info  Fetching updates..." -ForegroundColor Blue
git fetch origin main

# Check for local changes
$status = git status --porcelain
if ($status) {
    Write-Host "warn  You have local changes." -ForegroundColor Yellow
    Write-Host $status
    if (-not (Confirm "Continue with update? (Might overwrite changes)")) {
        Write-Host "info Update aborted." -ForegroundColor Blue
        exit 0
    }
}

# Simple conflict check
Write-Host "info  Checking for conflicts..." -ForegroundColor Blue
try {
    git pull origin main --quiet
    Write-Host "success Updated successfully." -ForegroundColor Green
} catch {
    Write-Host "warn  Merge conflicts detected." -ForegroundColor Yellow
    if (Confirm "Backup and force update?") {
        $backup = "$ConfigDir.bak.$([DateTimeOffset]::Now.ToUnixTimeSeconds())"
        Copy-Item -Path $ConfigDir -Destination $backup -Recurse
        Write-Host "success Backup created at $backup" -ForegroundColor Green
        git reset --hard origin/main
    } else {
        Write-Host "error Please resolve conflicts manually in $ConfigDir." -ForegroundColor Red
        exit 1
    }
}

Write-Host "info  Syncing plugins..." -ForegroundColor Blue
Start-Process nvim -ArgumentList "--headless", "+Rocks sync", "+qa" -Wait -NoNewWindow

Write-Host "success NvPak update complete!" -ForegroundColor Green
