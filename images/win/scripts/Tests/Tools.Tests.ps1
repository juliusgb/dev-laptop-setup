Import-Module (Join-Path $PSScriptRoot "..\SoftwareReport\SoftwareReport.Common.psm1") -DisableNameChecking

# skipping because not installed yet
Describe "R" -Skip {
    It "Rscript" {
        "Rscript --version" | Should -ReturnZeroExitCode
    }
}


Describe "DotnetTLS" -Skip:((Test-IsWin22) -or (Test-IsWinHome)) {
    It "Tls 1.2 is enabled" {
        [Net.ServicePointManager]::SecurityProtocol -band "Tls12" | Should -Be Tls12
    }
}


Describe "Mingw64" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "gcc" }
        @{ ToolName = "g++" }
        @{ ToolName = "make" }
    ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
    }
}


Describe "PowerShell Core" {
    It "pwsh" {
        "pwsh --version" | Should -ReturnZeroExitCode
    }

    It "Execute 2+2 command" {
        pwsh -Command "2+2" | Should -BeExactly 4
    }
}

# skipping because msys2 is not installed yet
Describe "Stack" -Skip {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "Pipx" {
    It "Pipx" {
        "pipx --version" | Should -ReturnZeroExitCode
    }
}

Describe "Kotlin" {
    $kotlinPackages =  @("kapt", "kotlin", "kotlinc", "kotlin-dce-js", "kotlinc-js", "kotlinc-jvm")

    It "<toolName> is available" -TestCases ($kotlinPackages | ForEach-Object { @{ toolName = $_ } })  {
        "$toolName -version" | Should -ReturnZeroExitCode
    }
}
