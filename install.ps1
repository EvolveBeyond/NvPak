# NvPak Professional Installer (Windows)
$ErrorActionPreference = 'Stop'
Write-Host "NvPak Professional Installer`n" -ForegroundColor Magenta
$ConfigDir = "$env:LOCALAPPDATA\nvim"
$Repo = "https://github.com/Pakrohk-DotFiles/NvPak.git"
if (Test-Path $ConfigDir) {
    Write-Host "Updating..." -ForegroundColor Blue
    git -C $ConfigDir pull
} else {
    Write-Host "Cloning..." -ForegroundColor Blue
    git clone --depth 1 $Repo $ConfigDir
}
Write-Host "Bootstrapping..." -ForegroundColor Blue
Start-Process nvim -ArgumentList "--headless", "+Rocks sync", "+qa" -Wait -NoNewWindow
Write-Host "Done!" -ForegroundColor Green
