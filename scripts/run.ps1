$exe = "vcs.exe"
$exePath = Join-Path -Path "target/release" -ChildPath $exe

Write-Host "[RUN] Launching VCS executable..." -ForegroundColor Cyan
& $exePath
Write-Host "=== Intelligent VCS Execution Complete ===" -ForegroundColor Cyan
