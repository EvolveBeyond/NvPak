# NvPak Smart Update Tool (Windows)
#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$ConfigDir = if ($env:NVPAK_CONFIG_DIR) { $env:NVPAK_CONFIG_DIR } else { (Join-Path $env:LOCALAPPDATA "nvim") }
$Branch = if ($env:NVPAK_BRANCH) { $env:NVPAK_BRANCH } else { "main" }

function Confirm ($msg) {
    $choice = Read-Host "question $msg [y/N]"
    return $choice -eq 'y'
}

function Invoke-NvimSync {
    # Runs `nvim --headless "+Rocks sync" "+qa"` with a 120s timeout.
    # Returns $true on exit code 0, $false otherwise (timeout or failure).
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = (Get-Command nvim).Source
    $psi.Arguments = '--headless "+Rocks sync" "+qa"'
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true

    $proc = [System.Diagnostics.Process]::Start($psi)
    if (-not $proc.WaitForExit(120000)) {
        try { $proc.Kill() } catch {}
        return $false
    }
    return ($proc.ExitCode -eq 0)
}

Clear-Host
Write-Host "NvPak Smart Update Tool`n" -ForegroundColor Magenta

if (-not (Test-Path (Join-Path $ConfigDir ".git"))) {
    Write-Host "error $ConfigDir is not a git repository." -ForegroundColor Red
    exit 1
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "error Git is required but not installed." -ForegroundColor Red
    exit 1
}

Set-Location $ConfigDir

Write-Host "info  Fetching updates..." -ForegroundColor Blue
git fetch origin $Branch
if ($LASTEXITCODE -ne 0) {
    Write-Host "error Failed to fetch from remote." -ForegroundColor Red
    exit 1
}

# Check for local changes
$status = git status --porcelain
if ($status) {
    Write-Host "warn  You have local changes." -ForegroundColor Yellow
    Write-Host $status
    if (-not (Confirm "Proceeding might overwrite these changes. Continue?")) {
        Write-Host "info  Update aborted by user." -ForegroundColor Blue
        exit 1
    }
}

# Conflict check via merge-tree (no working-tree mutation)
Write-Host "info  Checking for potential conflicts..." -ForegroundColor Blue
$mergeBase = git merge-base HEAD "origin/$Branch"
$conflictOutput = git merge-tree $mergeBase HEAD "origin/$Branch" | Select-String -Pattern '<<<<<<<'

if ($conflictOutput) {
    Write-Host "warn  Automatic merge might result in conflicts." -ForegroundColor Yellow
    if (Confirm "Do you want to backup your current config and force update?") {
        $backup = "$ConfigDir.bak.$([DateTimeOffset]::Now.ToUnixTimeSeconds())"
        Copy-Item -Path $ConfigDir -Destination $backup -Recurse
        if (-not (Test-Path $backup)) {
            Write-Host "error Backup failed. Aborting to protect your changes." -ForegroundColor Red
            exit 1
        }
        Write-Host "success Backup created at $backup" -ForegroundColor Green

        Write-Host "info  Force updating to the latest version..." -ForegroundColor Blue
        git stash --include-untracked 2>$null
        git reset --hard "origin/$Branch"
        if ($LASTEXITCODE -ne 0) {
            Write-Host "error Reset failed. Your changes are safe in the backup." -ForegroundColor Red
            exit 1
        }
        git stash pop 2>$null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "warn  Stash pop had conflicts. Your changes are in 'git stash list'." -ForegroundColor Yellow
        }
    } else {
        Write-Host "info  Attempting to merge anyway..." -ForegroundColor Blue
        git pull origin $Branch
        if ($LASTEXITCODE -ne 0) {
            Write-Host "error Merge failed. Please resolve conflicts manually in $ConfigDir." -ForegroundColor Red
            exit 1
        }
        Write-Host "success Merged successfully." -ForegroundColor Green
    }
} else {
    Write-Host "info  No obvious conflicts detected. Pulling..." -ForegroundColor Blue
    git pull origin $Branch
    if ($LASTEXITCODE -ne 0) {
        Write-Host "error Pull failed." -ForegroundColor Red
        exit 1
    }
}

if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "error Neovim (nvim) is required but not installed." -ForegroundColor Red
    exit 1
}

Write-Host "info  Syncing plugins (120s timeout)..." -ForegroundColor Blue
if (-not (Invoke-NvimSync)) {
    Write-Host "warn  Plugin sync had issues. Run ':Rocks sync' manually." -ForegroundColor Yellow
}

Write-Host "success NvPak updated to the latest version!" -ForegroundColor Green
