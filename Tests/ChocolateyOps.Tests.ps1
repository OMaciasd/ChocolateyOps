# Requires -Module Pester

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduleRoot = Join-Path $here '..'
$manifest = Join-Path $moduleRoot 'ChocolateyOps.psd1'

Describe 'ChocolateyOps' {
    BeforeAll {
        Import-Module $manifest -Force
    }

    AfterAll {
        Remove-Module ChocolateyOps -Force -ErrorAction SilentlyContinue
    }

    Context 'Status' {
        It 'returns a status object' {
            $status = Get-ChocolateyStatus
            $status | Should -Not -BeNullOrEmpty
            $status.PSObject.Properties.Name | Should -Contain 'Installed'
            $status.PSObject.Properties.Name | Should -Contain 'Healthy'
            $status.PSObject.Properties.Name | Should -Contain 'Version'
        }
    }

    Context 'Module exports' {
        It 'exports the expected public functions' {
            $commands = Get-Command -Module ChocolateyOps
            $commands.Name | Should -Contain 'Ensure-Chocolatey'
            $commands.Name | Should -Contain 'Get-ChocolateyStatus'
            $commands.Name | Should -Contain 'Invoke-ChocolateyMaintenance'
            $commands.Name | Should -Contain 'Update-Chocolatey'
        }
    }

    Context 'Ensure logic' {
        It 'can be invoked in WhatIf mode' {
            { Ensure-Chocolatey -WhatIf } | Should -Not -Throw
        }
    }
}