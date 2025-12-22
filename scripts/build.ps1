Write-Host "=== Intelligent VCS Runner ===" -ForegroundColor Cyan

# Paths
$rustLibDir = "target/x86_64-pc-windows-gnu/release"
$rustLibName = "core_rust"
$exe = "vcs.exe"
$exePath = Join-Path "build/release" $exe
$includePath = "src/module_c/include"

# Ensure build directories exist
if (-not (Test-Path "build/release")) {
    New-Item -ItemType Directory -Path "build/release" -Force | Out-Null
}

# --- Build Rust as static library ---
Write-Host "[BUILD] Compiling and Running Rust" -ForegroundColor Yellow
Push-Location "src/core_rust"
cargo run --release
if ($LASTEXITCODE -ne 0) {
    Pop-Location
    Write-Host "[ERROR] Rust build failed." -ForegroundColor Red
    exit 1
}
Pop-Location
