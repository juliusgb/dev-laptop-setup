###############################################################################
## Usage:
##  In PowerShell, run the Bootstrapper
##	Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/juliusgb/dev-laptop-windows/main/Bootstrap.ps1'))
## 	also refer to https://stackoverflow.com/questions/46060010/download-github-release-with-curl
##
## 	1. Open PowerShell Console as Administrator
##	2. Run Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
## 	3. Run .\Bootstrap.ps1
###############################################################################

#.\winrm\SetupWinRmForPacker.ps1
C:\opt\Packer\packer_1.8.2\packer.exe validate -syntax-only packer\template.pkr.hcl
C:\opt\Packer\packer_1.8.2\packer.exe validate packer\template.pkr.hcl
C:\opt\Packer\packer_1.8.2\packer.exe build packer\template.pkr.hcl
#.\winrm\CleanupWinrmSetupForPacker.ps1
