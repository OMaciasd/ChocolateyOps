Set-StrictMode -Version Latest

function Ensure-Chocolatey {

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [switch]$RepairIfUnhealthy
    )

    Write-ChocolateyOpsLog `
        -Level 'INFO' `
        -Message 'Ensuring Chocolatey state.' `
        -Data @{
            repairIfUnhealthy = [bool]$RepairIfUnhealthy
        }

    if (-not (Test-ChocolateyInstalled)) {

        if ($PSCmdlet.ShouldProcess(
            'Chocolatey',
            'Install'
        )) {

            Install-ChocolateyBootstrap
        }
    }

    $healthy = Test-ChocolateyHealthy

    if (-not $healthy -and $RepairIfUnhealthy) {

        if ($PSCmdlet.ShouldProcess(
            'Chocolatey',
            'Repair'
        )) {

            Repair-Chocolatey
        }
    }

    return New-ChocolateyOpsResult `
        -Success $true `
        -Action 'Ensure' `
        -Message 'Chocolatey ensured.' `
        -Version (Get-ChocolateyVersion) `
        -Data @{
            healthy = Test-ChocolateyHealthy
        }
}