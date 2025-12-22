$exe = "vcs.exe"
$exePath = Join-Path -Path "build/release" -ChildPath $exe

Write-Host "[RUN] Launching VCS executable..." -ForegroundColor Cyan
& $exePath
Write-Host "=== Intelligent VCS Execution Complete ===" -ForegroundColor Cyan