Set-StrictMode -Version Latest

function Ensure-Chocolatey {

    [CmdletBinding()]
    param()

    Write-ChocolateyOpsLog `
        -Level INFO `
        -Message 'Validating Chocolatey installation.'

    if (-not (Test-ChocolateyInstalled)) {

        Write-ChocolateyOpsLog `
            -Level WARN `
            -Message 'Chocolatey is not installed.'

        throw 'Chocolatey is not installed.'
    }

    if (-not (Test-ChocolateyHealthy)) {

        Write-ChocolateyOpsLog `
            -Level ERROR `
            -Message 'Chocolatey installation is unhealthy.'

        throw 'Chocolatey installation is unhealthy.'
    }

    $version = Get-ChocolateyVersion

    Write-ChocolateyOpsLog `
        -Level INFO `
        -Message "Chocolatey validated successfully. Version: $version"
}