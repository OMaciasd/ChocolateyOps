Set-StrictMode -Version Latest

function Update-ChocolateyPackage {

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    Ensure-Chocolatey | Out-Null

    if ($PSCmdlet.ShouldProcess(
        $Name,
        'Update package'
    )) {

        return Invoke-ChocolateyCommand `
            -Arguments @(
                'upgrade'
                $Name
                '-y'
                '--no-progress'
            )
    }
}