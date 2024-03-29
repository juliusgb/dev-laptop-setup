# Create shells folder
$shellPath = "C:\opt\shells"
New-Item -Path $shellPath -ItemType Directory -Force | Out-Null

# add a wrapper for C:\opt\msys64\usr\bin\bash.exe
@'
@echo off
setlocal
IF NOT DEFINED MSYS2_PATH_TYPE set MSYS2_PATH_TYPE=strict
IF NOT DEFINED MSYSTEM set MSYSTEM=mingw64
set CHERE_INVOKING=1
C:\opt\msys2\usr\bin\bash.exe -leo pipefail %*
'@ | Out-File -FilePath "$shellPath\msys2bash.cmd" -Encoding ascii

# gitbash <--> C:\Program Files\Git\bin\bash.exe
# CUSTOM
if (Test-Path "$shellPath\gitbash.exe") {
    Write-Host "Symlink "$shellPath\gitbash.exe" already Exists"
} else {
    New-Item -ItemType SymbolicLink -Path "$shellPath\gitbash.exe" -Target "$env:ProgramFiles\Git\bin\bash.exe" | Out-Null
}

# WSL is available on Windows Server 2019 and Windows Server 2022
if (-not (Test-IsWinHome))
{
    # wslbash <--> C:\Windows\System32\bash.exe
    New-Item -ItemType SymbolicLink -Path "$shellPath\wslbash.exe" -Target "$env:SystemRoot\System32\bash.exe" | Out-Null
}
