[CmdletBinding()]
param()

. $PSScriptRoot\ChocoHelpers.ps1
Export-ModuleMember -Function @(
'Install-ChocoPackage'
'Resolve-ChocoPackageVersion'
)

. $PSScriptRoot\InstallHelpers.ps1
Export-ModuleMember -Function @(
'Install-Binary'
'Invoke-DownloadWithRetry'
'Get-ToolsetContent'
'Get-TCToolPath'
'Get-TCToolVersionPath'
'Test-IsWin22'
'Test-IsWin19'
'Test-IsWinHome'
'Expand-7ZipArchive'
'Get-WindowsUpdateStates'
'Invoke-ScriptBlockWithRetry'
'Get-GithubReleasesByVersion'
'Resolve-GithubReleaseAssetUrl'
'Get-ChecksumFromGithubRelease'
'Get-ChecksumFromUrl'
'Test-FileChecksum'
'Test-FileSignature'
'Update-Environment'
)

. $PSScriptRoot\PathHelpers.ps1
Export-ModuleMember -Function @(
'Mount-RegistryHive'
'Dismount-RegistryHive'
'Add-MachinePathItem'
'Add-DefaultPathItem'
'Get-SystemVariable'
'Get-DefaultVariable'
'Set-SystemVariable'
'Set-DefaultVariable'
'Get-MachinePath'
'Get-DefaultPath'
'Set-MachinePath'
'Set-DefaultPath'
'Test-MachinePath'
'Add-MachinePathItem'
'Add-DefaultPathItem'
'New-ItemPath'
)

. $PSScriptRoot\TestsHelpers.ps1
Export-ModuleMember -Function @(
'Get-CommandResult'
'Get-WhichTool'
'Get-EnvironmentVariable'
'Update-Environment'
'Invoke-PesterTests'
'ShouldReturnZeroExitCode'
'ShouldReturnZeroExitCodeWithParam'
'ShouldMatchCommandOutput'
)

. $PSScriptRoot\VisualStudioHelpers.ps1

#Export-ModuleMember -Function @(
#    'Connect-Hive'
#    'Disconnect-Hive'
#    'Test-MachinePath'
#    'Get-MachinePath'
#    'Get-DefaultPath'
#    'Set-MachinePath'
#    'Set-DefaultPath'
#    'Add-MachinePathItem'
#    'Add-DefaultPathItem'
#    'Add-DefaultItem'
#    'Get-SystemVariable'
#    'Get-DefaultVariable'
#    'Set-SystemVariable'
#    'Set-DefaultVariable'
#    'Install-Binary'
#    'Install-VisualStudio'
#    'Get-ToolsetContent'
#    'Get-ToolsetToolFullPath'
#    'Stop-SvcWithErrHandling'
#    'Set-SvcWithErrHandling'
#    'Start-DownloadWithRetry'
#    'Get-VsixExtenstionFromMarketplace'
#    'Install-VsixExtension'
#    'Get-VSExtensionVersion'
#    'Get-WinVersion'
#	'Test-IsWinHome'
#    'Test-IsWin22'
#    'Test-IsWin19'
#    'Test-IsWin16'
#    'Choco-Install'
#    'Send-RequestToCocolateyPackages'
#    'Get-LatestChocoPackageVersion'
#    'Get-GitHubPackageDownloadUrl'
#    'Extract-7Zip'
#    'Get-CommandResult'
#    'Get-WhichTool'
#    'Get-EnvironmentVariable'
#    'Invoke-PesterTests'
#    'Invoke-SBWithRetry'
#    'Get-VsCatalogJsonPath'
#    'Install-AndroidSDKPackages'
#    'Get-AndroidPackages'
#    'Get-AndroidPackagesByName'
#    'Get-AndroidPackagesByVersion'
#    'Get-VisualStudioInstance'
#    'Get-VisualStudioComponents'
#    'Get-WindowsUpdatesHistory'
#    'New-ItemPath'
#)
