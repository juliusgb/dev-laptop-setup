$global:ErrorActionPreference = "Stop"
$global:ProgressPreference = "SilentlyContinue"
$ErrorView = "NormalView"
Set-StrictMode -Version Latest

Import-Module MarkdownPS
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.WebServers.psm1") -DisableNameChecking

$markdown = ""

$OSName = Get-OSName
$markdown += New-MDHeader "$OSName" -Level 1

$OSVersion = Get-OSVersion
$markdown += New-MDList -Style Unordered -Lines @(
    "$OSVersion"
    "Image Version: $env:IMAGE_VERSION"
)

if ((Test-IsWin19) -or (Test-IsWin22))
{
    $markdown += New-MDHeader "Enabled windows optional features" -Level 2
    $markdown += New-MDList -Style Unordered -Lines @(
        "Windows Subsystem for Linux [WSLv1]"
    )
}

$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3
$languageTools = @(
    (Get-BashVersion),
    (Get-GoVersion),
    (Get-JuliaVersion),
    (Get-NodeVersion),
    (Get-PerlVersion),
    (Get-PythonVersion),
    (Get-RubyVersion),
    (Get-KotlinVersion)
)
$markdown += New-MDList -Style Unordered -Lines ($languageTools | Sort-Object)

$packageManagementList = @(
    (Get-ChocoVersion),
    (Get-CondaVersion),
    (Get-NPMVersion),
    (Get-NugetVersion),
    (Get-PipxVersion),
    (Get-PipVersion),
    (Get-RubyGemsVersion),
    (Get-YarnVersion)
)

$markdown += New-MDHeader "Package Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines ($packageManagementList | Sort-Object)

$markdown += New-MDHeader "Project Management" -Level 3
$projectManagementTools = @(
    (Get-AntVersion),
    (Get-GradleVersion),
    (Get-MavenVersion)
)

$markdown += New-MDList -Style Unordered -Lines ($projectManagementTools | Sort-Object)

$markdown += New-MDHeader "Tools" -Level 3
$toolsList = @(
    (Get-7zipVersion),
    (Get-Aria2Version),
    (Get-CMakeVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-InnoSetupVersion),
    (Get-JQVersion),
    (Get-MinGWVersion),
    (Get-NewmanVersion),
    (Get-OpenSSLVersion),
    (Get-PackerVersion),
    (Get-PulumiVersion),
    (Get-YAMLLintVersion)
)
if ((Test-IsWin16) -or (Test-IsWin19)) {
    $toolsList += @(
        (Get-GoogleCloudSDKVersion),
        (Get-ParcelVersion)
    )
}
$markdown += New-MDList -Style Unordered -Lines ($toolsList | Sort-Object)

$markdown += New-MDHeader "CLI Tools" -Level 3
$cliTools = @(
    (Get-AWSCLIVersion),
    (Get-AWSSAMVersion),
    (Get-AWSSessionManagerVersion)
)
if ((Test-IsWin16) -or (Test-IsWin19)) {
    $cliTools += @(
        (Get-CloudFoundryVersion)
    )
}
$markdown += New-MDList -Style Unordered -Lines ($cliTools | Sort-Object)

# $markdown += New-MDHeader "Rust Tools" -Level 3
# $markdown += New-MDList -Style Unordered -Lines (@(
#     "Rust $(Get-RustVersion)",
#     "Rustup $(Get-RustupVersion)",
#     "Cargo $(Get-RustCargoVersion)",
#     "Rustdoc $(Get-RustdocVersion)"
#     ) | Sort-Object
# )

# $markdown += New-MDHeader "Packages" -Level 4
# $markdown += New-MDList -Style Unordered -Lines (@(
#     (Get-BindgenVersion),
#     (Get-CargoAuditVersion),
#     (Get-CargoOutdatedVersion),
#     (Get-CbindgenVersion),
#     "Rustfmt $(Get-RustfmtVersion)",
#     "Clippy $(Get-RustClippyVersion)"
#     ) | Sort-Object
# )

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Shells" -Level 3
$markdown += Get-ShellTarget
$markdown += New-MDNewLine


$markdown += New-MDHeader "Cached Tools" -Level 3
$markdown += (Build-CachedToolsMarkdown)

$markdown += New-MDHeader "Databases" -Level 3
$markdown += Build-DatabasesMarkdown

$markdown += Build-WebServersSection


# PowerShell Tools
$markdown += New-MDHeader "PowerShell Tools" -Level 3
$markdown += New-MDList -Lines (Get-PowershellCoreVersion) -Style Unordered

$markdown += New-MDHeader "Powershell Modules" -Level 4
$markdown += Get-PowerShellModules | New-MDTable
$markdown += New-MDNewLine

# Docker images section


Test-BlankElement -Markdown $markdown
$markdown | Out-File -FilePath "C:\opt\InstalledSoftware.md"
