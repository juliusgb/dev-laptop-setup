function Get-Aria2Version {
    (aria2c -v | Out-String) -match "(?<version>(\d+\.){1,}\d+)" | Out-Null
    $aria2Version = $Matches.Version
    return "aria2 $aria2Version"
}

function Get-AzCosmosDBEmulatorVersion {
    $regKey = gci HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | gp | ? { $_.DisplayName -eq 'Azure Cosmos DB Emulator' }
    $installDir = $regKey.InstallLocation
    $exeFilePath = Join-Path $installDir 'CosmosDB.Emulator.exe'
    $version = (Get-Item $exeFilePath).VersionInfo.FileVersion
    return "Azure CosmosDb Emulator $version"
}

function Get-BazelVersion {
    ((cmd /c "bazel --version 2>&1") | Out-String) -match "bazel (?<version>\d+\.\d+\.\d+)" | Out-Null
    $bazelVersion = $Matches.Version
    return "Bazel $bazelVersion"
}

function Get-BazeliskVersion {
    ((cmd /c "bazelisk version 2>&1") | Out-String) -match "Bazelisk version: v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $bazeliskVersion = $Matches.Version
    return "Bazelisk $bazeliskVersion"
}

function Get-BicepVersion {
    (bicep --version | Out-String) -match  "bicep cli version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $bicepVersion = $Matches.Version
    return "Bicep $bicepVersion"
}

function Get-RVersion {
    ($(cmd /c "Rscript --version 2>&1") | Out-String) -match "Rscript .* version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $rVersion = $Matches.Version
    return "R $rVersion"
}

function Get-CMakeVersion {
    ($(cmake -version) | Out-String) -match  "cmake version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $cmakeVersion = $Matches.Version
    return "CMake $cmakeVersion"
}

function Get-CodeQLBundleVersion {
    $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "codeql" | Join-Path -ChildPath "*"
    $CodeQLVersionPath = Get-ChildItem $CodeQLVersionsWildcard | Select-Object -First 1 -Expand FullName
    $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql.exe"
    $CodeQLVersion = & $CodeQLPath version --quiet
    return "CodeQL Action Bundle $CodeQLVersion"
}

function Get-DockerVersion {
    $dockerVersion = $(docker version --format "{{.Server.Version}}")
    return "Docker $dockerVersion"
}

function Get-DockerComposeVersion {
    $dockerComposeVersion = docker-compose version --short
    return "Docker Compose v1 $dockerComposeVersion"
}

function Get-DockerComposeVersionV2 {
    $dockerComposeVersion = docker compose version --short
    return "Docker Compose v2 $dockerComposeVersion"
}

function Get-DockerWincredVersion {
    $dockerCredVersion = $(docker-credential-wincred version)
    return "Docker-wincred $dockerCredVersion"
}

function Get-GitVersion {
    $gitVersion = git --version | Take-Part -Part -1
    return "Git $gitVersion"
}

function Get-GitLFSVersion {
    $(git-lfs version) -match "git-lfs\/(?<version>\d+\.\d+\.\d+)" | Out-Null
    $gitLfsVersion = $Matches.Version
    return "Git LFS $gitLfsVersion"
}

function Get-InnoSetupVersion {
    return $(choco list --local-only innosetup) | Select-String -Pattern "InnoSetup"
}

function Get-JQVersion {
    $jqVersion = ($(jq --version) -Split "jq-")[1]
    return "jq $jqVersion"
}

function Get-KubectlVersion {
    $kubectlVersion = (kubectl version --client --output=json | ConvertFrom-Json).clientVersion.gitVersion.Replace('v','')
    return "Kubectl $kubectlVersion"
}

function Get-KindVersion {
    $(kind version) -match "kind v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $kindVersion = $Matches.Version
    return "Kind $kindVersion"
}

function Get-MinGWVersion {
    (gcc --version | Select-String -Pattern "MinGW-W64") -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $mingwVersion = $Matches.Version
    return "Mingw-w64 $mingwVersion"
}

function Get-MySQLVersion {
    $mysqlCommand = Get-Command -Name "mysql"
    $mysqlVersion = $mysqlCommand.Version.ToString()
    return "MySQL $mysqlVersion"
}

function Get-SQLOLEDBDriverVersion {
    $SQLOLEDBDriverVersion = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOLEDBSQL' InstalledVersion).InstalledVersion
    return "SQL OLEDB Driver $SQLOLEDBDriverVersion"
}

function Get-MercurialVersion {
    ($(hg --version) | Out-String) -match "version (?<version>\d+\.\d+\.?\d*)" | Out-Null
    $mercurialVersion = $Matches.Version
    return "Mercurial $mercurialVersion"
}


function Get-OpenSSLVersion {
    $(openssl version) -match "OpenSSL (?<version>\d+\.\d+\.\d+\w?) " | Out-Null
    $opensslVersion = $Matches.Version
    return "OpenSSL $opensslVersion"
}

function Get-PackerVersion {
    # Packer 1.7.1 has a bug and outputs version to stderr instead of stdout https://github.com/hashicorp/packer/issues/10855
    ($(cmd /c "packer --version 2>&1") | Out-String) -match "(?<version>(\d+.){2}\d+)" | Out-Null
    $packerVersion = $Matches.Version
    return "Packer $packerVersion"
}

function Get-ParcelVersion {
    $parcelVersion = parcel --version
    return "Parcel $parcelVersion"
}

function Get-PulumiVersion {
    return "Pulumi $(pulumi version)"
}


function Get-AWSCLIVersion {
    $(aws --version) -match "aws-cli\/(?<version>\d+\.\d+\.\d+)" | Out-Null
    $awscliVersion = $Matches.Version
    return "AWS CLI $awscliVersion"
}

function Get-AWSSAMVersion {
    $(sam --version) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $awssamVersion = $Matches.Version
    return "AWS SAM CLI $awssamVersion"
}

function Get-AWSSessionManagerVersion {
    $awsSessionManagerVersion = $(session-manager-plugin --version)
    return "AWS Session Manager CLI $awsSessionManagerVersion"
}

function Get-CloudFoundryVersion {
    $(cf version) -match  "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $cfVersion = $Matches.Version
    return "Cloud Foundry CLI $cfVersion"
}

function Get-7zipVersion {
    (7z | Out-String) -match "7-Zip (?<version>\d+\.\d+\.?\d*)" | Out-Null
    $version = $Matches.Version
    return "7zip $version"
}

# add again after haskell installation
# function Get-GHCVersion {
#     ((ghc --version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
#     $ghcVersion = $Matches.Version
#     return "ghc $ghcVersion"
# }

# function Get-CabalVersion {
#     ((cabal --version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+\.\d+)" | Out-Null
#     $cabalVersion = $Matches.Version
#     return "Cabal $cabalVersion"
# }

# function Get-StackVersion {
#     ((stack --version --quiet) | Out-String) -match "Version (?<version>\d+\.\d+\.\d+)," | Out-Null
#     $stackVersion = $Matches.Version
#     return "Stack $stackVersion"
# }

function Get-GoogleCloudSDKVersion {
    (gcloud --version) -match "Google Cloud SDK"
}


function Get-NewmanVersion {
    return "Newman $(newman --version)"
}
