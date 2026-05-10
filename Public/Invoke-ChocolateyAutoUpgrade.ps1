function Invoke-ChocolateyAutoUpgrade {

    [CmdletBinding()]
    param(
        [switch]$RepairIfUnhealthy
    )

    if (-not (Test-ChocolateyHealthy)) {

        if ($RepairIfUnhealthy) {

            Repair-ChocolateyInstallation
        }
        else {

            throw 'Chocolatey unhealthy.'
        }
    }

    $packages = Get-ChocolateyOutdatedPackages

    if (-not $packages) {

        return [PSCustomObject]@{
            Success = $true
            PackagesDetected = 0
            PackagesUpdated = 0
        }
    }

    foreach ($package in $packages) {

        Write-ChocoLog "Upgrading $($package.Package)"

        choco upgrade $package.Package -y --no-progress
    }

    [PSCustomObject]@{
        Success = $true
        PackagesDetected = $packages.Count
        PackagesUpdated = $packages.Count
    }
}