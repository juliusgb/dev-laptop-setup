Describe "PostgreSQL" {
    $psqlTests = @(
        @{envVar = "PGROOT"; pgPath = Get-EnvironmentVariable "PGROOT" }
        @{envVar = "PGBIN"; pgPath = Get-EnvironmentVariable "PGBIN" }
        @{envVar = "PGDATA"; pgPath = Get-EnvironmentVariable "PGDATA" }
    )

    Context "Environment variable" {
        It "PGUSER contains postgres" {
            Get-EnvironmentVariable "PGUSER" | Should -Be "postgres"
        }

        It "PGPASSWORD contains root" {
            Get-EnvironmentVariable "PGPASSWORD" | Should -Be "root"
        }

        It "<envVar> environment variable exists" -TestCases $psqlTests {
            Get-EnvironmentVariable $envVar | Should -Not -BeNullOrEmpty
        }
    }

    Context "Path" {
        It "<pgPath> path exists" -TestCases $psqlTests {
            $pgPath | Should -Exist
        }
    }

    Context "Service" {
        $psqlService = Get-Service -Name postgresql*
        $psqlServiceTests = @{
            Name      = $psqlService.Name
            Status    = $psqlService.Status
            StartType = $psqlService.StartType
        }

        It "<Name> service is stopped" -TestCases $psqlServiceTests {
            $Status | Should -Be "Stopped"
        }

        It "<Name> service is disabled" -TestCases $psqlServiceTests {
            $StartType | Should -Be "Disabled"
        }
    }

    Context "PostgreSQL version" {
        It "PostgreSQL version should correspond to the version in the toolset" {
            $toolsetVersion = (Get-ToolsetContent).postgresql.version
            # Client version
            (& $env:PGBIN\psql --version).split()[-1] | Should -BeLike "$toolsetVersion*"
            # Server version
            (& $env:PGBIN\pg_config --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        }
    }
}

Describe "MySQL" -Skip {
    It "MySQL CLI" {
        $MysqlVersion = (Get-ToolsetContent).mysql.version
        mysql -V | Should -BeLike "*${MysqlVersion}*"
    }
}
