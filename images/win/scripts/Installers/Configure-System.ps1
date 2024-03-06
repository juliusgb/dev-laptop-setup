################################################################################
##  File:  Configure-System.ps1
##  Desc:  Applies various configuration settings to the final image
################################################################################

Write-Host "Clean up various directories"
@(
    "$env:SystemRoot\logs",
    "$env:SystemRoot\Temp",
    "$env:TEMP"
) | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "Removing $_"
        cmd /c "takeown /d Y /R /f $_ 2>&1" | Out-Null
        cmd /c "icacls $_ /grant:r administrators:f /t /c /q 2>&1" | Out-Null
        Remove-Item $_ -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

# Clean yarn and npm cache
cmd /c "yarn cache clean 2>&1" | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Failed to clean yarn cache"
}

cmd /c "npm cache clean --force 2>&1" | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Failed to clean npm cache"
}

Write-Host "Finalize-VM.ps1 - completed"
