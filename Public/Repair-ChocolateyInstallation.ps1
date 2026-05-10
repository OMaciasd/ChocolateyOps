function Repair-ChocolateyInstallation {

    [CmdletBinding()]
    param()

    Write-ChocoLog "Starting Chocolatey remediation..." WARN

    $chocoRoot = "$env:ProgramData\chocolatey"

    $backupRoot = "$env:ProgramData\chocolatey_backup_$(Get-Date -Format yyyyMMddHHmmss)"

    if (Test-Path $chocoRoot) {

        Write-ChocoLog "Backing up corrupted installation..."

        Copy-Item `
            $chocoRoot `
            $backupRoot `
            -Recurse `
            -Force

        Write-ChocoLog "Removing corrupted installation..."

        Remove-Item `
            $chocoRoot `
            -Recurse `
            -Force
    }

    Write-ChocoLog "Reinstalling Chocolatey..."

    Set-ExecutionPolicy Bypass -Scope Process -Force

    [System.Net.ServicePointManager]::SecurityProtocol =
        [System.Net.SecurityProtocolType]::Tls12

    Invoke-Expression (
        Invoke-WebRequest https://community.chocolatey.org/install.ps1 -UseBasicParsing
    ).Content

    Start-Sleep -Seconds 10

    $exe = Get-ChocoExecutable

    if (-not $exe) {

        throw 'Chocolatey remediation failed.'
    }

    Write-ChocoLog "Chocolatey restored successfully."

    return [PSCustomObject]@{
        Success = $true
        Backup  = $backupRoot
        ExePath = $exe
    }
}