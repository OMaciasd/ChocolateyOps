function Initialize-Chocolatey {

    [CmdletBinding()]
    param()

    if (Test-ChocolateyHealthy) {

        Write-ChocoLog "Chocolatey already healthy."

        return
    }

    Write-ChocoLog "Installing Chocolatey..."

    Set-ExecutionPolicy Bypass -Scope Process -Force

    [System.Net.ServicePointManager]::SecurityProtocol =
        [System.Net.SecurityProtocolType]::Tls12

    Invoke-Expression (
        Invoke-WebRequest https://community.chocolatey.org/install.ps1 -UseBasicParsing
    ).Content

    Start-Sleep -Seconds 5

    if (-not (Test-ChocolateyHealthy)) {
        throw 'Chocolatey installation failed.'
    }

    Write-ChocoLog "Chocolatey installed successfully."
}