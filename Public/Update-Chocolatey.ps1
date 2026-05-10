Set-StrictMode -Version Latest

function Update-Chocolatey {

    [CmdletBinding(SupportsShouldProcess)]
    param()

    Ensure-Chocolatey -RepairIfUnhealthy | Out-Null

    if ($PSCmdlet.ShouldProcess(
        'Chocolatey',
        'Update'
    )) {

        return Update-ChocolateyCore
    }
}