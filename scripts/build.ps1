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
Write-Host "[BUILD] Compiling Rust core as static library..." -ForegroundColor Yellow
Push-Location "src/core_rust"
cargo build --release --target x86_64-pc-windows-gnu
if ($LASTEXITCODE -ne 0) {
    Pop-Location
    Write-Host "[ERROR] Rust build failed." -ForegroundColor Red
    exit 1
}
Pop-Location

if (-not (Test-Path "$rustLibDir/lib$rustLibName.a")) {
    Write-Host "[ERROR] Rust static library not found." -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Rust static library built." -ForegroundColor Green

# --- Build C modules and link everything ---
Write-Host "[BUILD] Compiling and linking C modules..." -ForegroundColor Yellow

# Collect all C files
$cFiles = Get-ChildItem "src/module_c/src/*.c" | ForEach-Object { $_.FullName }

# GCC: compile AND link in one pass
gcc $cFiles `
    -I $includePath `
    -L $rustLibDir `
    -l $rustLibName `
    -lpthread -ldl -lm -lws2_32 -lws2_32 -lntdll -luserenv -lws2_32 -lws2_32 `
    -o $exePath

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Linking failed." -ForegroundColor Red
    exit 1
}

Write-Host "[OK] C modules compiled and linked into $exe" -ForegroundColor Green

# --- Run the executable ---
Write-Host "[RUN] Launching VCS executable..." -ForegroundColor Cyan
& $exePath

Write-Host "=== Intelligent VCS Execution Complete ===" -ForegroundColor Cyan
