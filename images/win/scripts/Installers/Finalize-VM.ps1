################################################################################
##  File:  Finalize-VM.ps1
##  Desc:  Clean up temp folders after installs to save space
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
cmd /c "npm cache clean --force 2>&1" | Out-Null

Write-Host "Finalize-VM.ps1 - completed"
