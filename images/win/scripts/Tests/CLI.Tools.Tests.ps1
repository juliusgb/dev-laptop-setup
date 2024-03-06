
Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }

    It "Session Manager Plugin for the AWS CLI" {
        @(session-manager-plugin) -Match '\S' | Out-String | Should -Match "plugin was installed successfully"
    }

    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }
}


Describe "GitHub CLI" -Skip {
    It "gh" {
        "gh --version" | Should -ReturnZeroExitCode
    }
}
