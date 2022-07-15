
Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }

    It "Session Manager Plugin for the AWS CLI" {
        session-manager-plugin | Out-String | Should -Match "plugin was installed successfully"
    }

    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }
}

Describe "GitHub CLI" {
    It "gh" {
        "gh --version" | Should -ReturnZeroExitCode
    }
}
