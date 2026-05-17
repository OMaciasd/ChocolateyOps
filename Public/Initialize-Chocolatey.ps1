Set-StrictMode -Version Latest

function Initialize-Chocolatey {

    [CmdletBinding()]
    param()

    if (Test-ChocolateyHealthy) {

        Write-ChocolateyOpsLog `
            -Level INFO `
            -Message 'Chocolatey already healthy.'

        return
    }

    Write-ChocolateyOpsLog `
        -Level WARN `
        -Message 'Chocolatey not detected or unhealthy.'

    $installScript = 'https://community.chocolatey.org/install.ps1'

    try {

        Write-ChocolateyOpsLog `
            -Level INFO `
            -Message 'Installing Chocolatey.'

        Set-ExecutionPolicy Bypass `
            -Scope Process `
            -Force

        Invoke-Expression (
            Invoke-RestMethod $installScript
        )

        if (-not (Test-ChocolateyHealthy)) {

            throw 'Chocolatey installation validation failed.'
        }

        $version = Get-ChocolateyVersion

        Write-ChocolateyOpsLog `
            -Level INFO `
            -Message "Chocolatey installed successfully. Version: $version"
    }
    catch {

        Write-ChocolateyOpsLog `
            -Level ERROR `
            -Message $_.Exception.Message

        throw
    }
}