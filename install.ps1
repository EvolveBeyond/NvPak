# NvPak Professional Installer (Windows) - June 2026
$ErrorActionPreference = 'Stop'

Write-Host "NvPak Professional Installer (v2026)`n" -ForegroundColor Magenta

$ConfigDir = "$env:LOCALAPPDATA\nvim"
$Repo = "https://github.com/EvolveBeyond/NvPak.git"

function Check-NeovimVersion {
    if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
        Write-Error "Neovim is not installed. Please install Neovim v0.10.0+ and try again."
        exit 1
    }
    $versionString = (nvim --version | Select-Object -First 1)
    if ($versionString -match 'v(\d+\.\d+\.\d+)') {
        $version = [version]$Matches[1]
        if ($version -lt [version]"0.10.0") {
            Write-Error "NvPak requires Neovim v0.10.0 or higher. You have $version."
            exit 1
        }
    }
}

Check-NeovimVersion

if (Test-Path $ConfigDir) {
    if (Test-Path (Join-Path $ConfigDir ".git")) {
        Write-Host "Updating NvPak in $ConfigDir..." -ForegroundColor Blue
        git -C $ConfigDir pull
    } else {
        Write-Error "$ConfigDir exists and is not a git repository. Please backup and remove it before running this script."
        exit 1
    }
} else {
    Write-Host "Cloning NvPak into $ConfigDir..." -ForegroundColor Blue
    git clone --depth 1 $Repo $ConfigDir
}

Write-Host "Bootstrapping plugins and configuration..." -ForegroundColor Blue
# Using rocks.nvim
Start-Process nvim -ArgumentList "--headless", "+Rocks sync", "+qa" -Wait -NoNewWindow

Write-Host "Done!" -ForegroundColor Green
Write-Host "Start it by running: nvim"
