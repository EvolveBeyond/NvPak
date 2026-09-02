# NvPak Professional Installer (Windows Zen Edition)
#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$Repo = if ($env:NVPAK_REPO) { $env:NVPAK_REPO } else { "https://github.com/EvolveBeyond/NvPak.git" }
$ConfigDir = Join-Path $env:LOCALAPPDATA "nvim"

function Confirm ($msg) {
    $choice = Read-Host "question $msg [y/N]"
    return $choice -eq 'y'
}

function Invoke-NvimBootstrap {
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
    scoop install git neovim ripgrep fd 7zip win32yank -s
    if ($LASTEXITCODE -ne 0) {
        Write-Host "info  Some packages already present or install reported issues." -ForegroundColor Blue
    }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "error Git is required but not installed. Aborting." -ForegroundColor Red
    exit 1
}

if (Test-Path $ConfigDir) {
    if (Test-Path (Join-Path $ConfigDir ".git")) {
        Write-Host "info  Updating NvPak..." -ForegroundColor Blue
        git -C $ConfigDir pull
        if ($LASTEXITCODE -ne 0) {
            Write-Host "warn  Update failed. Continuing with existing config." -ForegroundColor Yellow
        }
    } else {
        if (Confirm "Non-git directory found at $ConfigDir. Backup and re-clone?") {
            Rename-Item $ConfigDir "$ConfigDir.bak.$([DateTimeOffset]::Now.ToUnixTimeSeconds())"
            git clone --depth 1 $Repo $ConfigDir
            if ($LASTEXITCODE -ne 0) {
                Write-Host "error Clone failed." -ForegroundColor Red
                exit 1
            }
        } else {
            Write-Host "error Installation aborted by user." -ForegroundColor Red
            exit 1
        }
    }
} else {
    Write-Host "info  Cloning NvPak..." -ForegroundColor Blue
    git clone --depth 1 $Repo $ConfigDir
    if ($LASTEXITCODE -ne 0) {
        Write-Host "error Clone failed." -ForegroundColor Red
        exit 1
    }
}

if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "error Neovim (nvim) is required but not installed. Aborting." -ForegroundColor Red
    exit 1
}

Write-Host "info  Bootstrapping plugins (120s timeout)..." -ForegroundColor Blue
if (-not (Invoke-NvimBootstrap)) {
    Write-Host "warn  Plugin bootstrap had issues. Run ':Rocks sync' manually." -ForegroundColor Yellow
}

Write-Host "success NvPak installation complete!" -ForegroundColor Green
