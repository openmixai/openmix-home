# 下载 OpenMix 官网静态依赖到 assets/（需可访问外网）
# 用法: powershell -ExecutionPolicy Bypass -File scripts/download-assets.ps1
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$assets = Join-Path $root 'assets'

function Get-Remote {
    param([string]$Uri, [string]$OutFile)
    $dir = Split-Path -Parent $OutFile
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Invoke-WebRequest -Uri $Uri -OutFile $OutFile -UseBasicParsing -TimeoutSec 120
}

Write-Host 'Downloading Tailwind CDN script...'
Get-Remote 'https://cdn.tailwindcss.com' (Join-Path $assets 'vendor/tailwindcss.js')

Write-Host 'Downloading Font Awesome 4.7...'
Get-Remote 'https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css' (Join-Path $assets 'vendor/font-awesome/css/font-awesome.min.css')
Get-Remote 'https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/fonts/fontawesome-webfont.woff2?v=4.7.0' (Join-Path $assets 'vendor/font-awesome/fonts/fontawesome-webfont.woff2')

Write-Host 'Downloading Google Fonts (woff2 subsets)...'
$gf = 'https://fonts.gstatic.com/s'
Get-Remote "$gf/jetbrainsmono/v24/tDbv2o-flEEny0FZhsfKu5WU4zr3E_BX0PnT8RD8yKwBNntkaToggR7BYRbKPxDcwg.woff2" (Join-Path $assets 'fonts/jetbrains-mono-latin.woff2')
Get-Remote "$gf/jetbrainsmono/v24/tDbv2o-flEEny0FZhsfKu5WU4zr3E_BX0PnT8RD8yKwBNntkaToggR7BYRbKPx7cwhsk.woff2" (Join-Path $assets 'fonts/jetbrains-mono-latin-ext.woff2')
Get-Remote "$gf/plusjakartasans/v12/LDIoaomQNQcsA88c7O9yZ4KMCoOg4Ko20yw.woff2" (Join-Path $assets 'fonts/plus-jakarta-sans-latin.woff2')
Get-Remote "$gf/plusjakartasans/v12/LDIoaomQNQcsA88c7O9yZ4KMCoOg4Ko40yyygA.woff2" (Join-Path $assets 'fonts/plus-jakarta-sans-latin-ext.woff2')

Write-Host 'Done. Assets under:' $assets
