Describe "Rust" -Skip {
    BeforeAll {
        $env:RUSTUP_HOME = "$env:USERPROFILE\.rustup"
        $env:CARGO_HOME = "$env:USERPROFILE\.cargo"
        $env:Path += ";$env:CARGO_HOME\bin"
    }

    $rustTools = @(
        @{ToolName = "rustup"; binPath = "$env:USERPROFILE\.cargo\bin\rustup.exe"}
        @{ToolName = "rustc"; binPath = "$env:USERPROFILE\.cargo\bin\rustc.exe"}
        @{ToolName = "cargo"; binPath = "$env:USERPROFILE\.cargo\bin\cargo.exe"}
        @{ToolName = "cargo audit"; binPath = "$env:USERPROFILE\.cargo\bin\cargo-audit.exe"}
        @{ToolName = "cargo outdated"; binPath = "$env:USERPROFILE\.cargo\bin\cargo-outdated.exe"}
    )

    $rustEnvNotExists = @(
        @{envVar = "RUSTUP_HOME"}
        @{envVar = "CARGO_HOME"}
    )

    It "$env:USERPROFILE\.rustup and $env:USERPROFILE\.cargo folders exist" {
        "$env:USERPROFILE\.rustup", "$env:USERPROFILE\.cargo" | Should -Exist
    }

    It "<envVar> environment variable does not exist" -TestCases $rustEnvNotExists {
        [Environment]::GetEnvironmentVariables("Machine").ContainsKey($envVar) | Should -BeFalse
    }

    It "<ToolName> is installed to the '<binPath>' folder" -TestCases $rustTools {
        "$ToolName --version" | Should -ReturnZeroExitCode
        $binPath | Should -Exist
    }
}
