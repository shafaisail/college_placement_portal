Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "      STOPPING COLLEGE PLACEMENT PORTAL SERVICES" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

$ports = @(5000, 8000, 5173)
foreach ($targetPort in $ports) {
    $connections = Get-NetTCPConnection -LocalPort $targetPort -ErrorAction SilentlyContinue
    if ($connections) {
        foreach ($conn in $connections) {
            $processId = $conn.OwningProcess
            if ($processId -and $processId -gt 0 -and $processId -ne $PID) {
                try {
                    Stop-Process -Id $processId -Force -ErrorAction SilentlyContinue
                    Write-Host "[STOPPED] Terminated process (PID $processId) on port $targetPort" -ForegroundColor Green
                } catch {
                    Write-Host "[WARNING] Could not terminate process PID $processId : $_" -ForegroundColor Yellow
                }
            }
        }
    } else {
        Write-Host "[OK] Port $targetPort is clear." -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "All College Placement Portal services have been stopped." -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
