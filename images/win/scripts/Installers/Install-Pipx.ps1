################################################################################
##  File:  Install-Pipx.ps1
##  Desc:  Install pipx and pipx packages
################################################################################

Write-Host "Installing pipx..."

#   Set custom directorys for pipx
$env:PIPX_BIN_DIR = "C:\opt\pipx_bin"
$env:PIPX_HOME = "C:\opt\pipx"

#   Install pipx
pip install pipx

if ($LASTEXITCODE -ne 0) {
    throw "pipx installation failed with exit code $LASTEXITCODE"
}

#   Set environment variables
Add-MachinePathItem "${env:PIPX_BIN_DIR}"
[Environment]::SetEnvironmentVariable("PIPX_BIN_DIR", $env:PIPX_BIN_DIR, "Machine")
[Environment]::SetEnvironmentVariable("PIPX_HOME", $env:PIPX_HOME, "Machine")

#   Test pipx
Invoke-PesterTests -TestFile "Tools" -TestName "Pipx"

Write-Host "Installing pipx packages..."

$pipxToolset = (Get-ToolsetContent).pipx
foreach ($tool in $pipxToolset) {
    if ($tool.python) {
        $pythonPath = (Get-Item -Path "${env:AGENT_TOOLSDIRECTORY}\Python\${tool.python}.*\x64\python-${tool.python}*").FullName
        Write-Host "Install ${tool.package} into python ${tool.python}"
        pipx install $tool.package --python $pythonPath
    } else {
        Write-Host "Install ${tool.package} into default python"
        pipx install $tool.package
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Package ${tool.package} installation failed with exit code $LASTEXITCODE"
    }
}

Invoke-PesterTests -TestFile "PipxPackages"
