Set-StrictMode -Version Latest

function Remove-ChocolateyPackage {

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    Ensure-Chocolatey | Out-Null

    if ($PSCmdlet.ShouldProcess(
        $Name,
        'Remove package'
    )) {

        return Invoke-ChocolateyCommand `
            -Arguments @(
                'uninstall'
                $Name
                '-y'
                '--no-progress'
            )
    }
}