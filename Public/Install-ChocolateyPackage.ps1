Set-StrictMode -Version Latest

function Install-ChocolateyPackage {

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter()]
        [string]$Version,

        [switch]$Force
    )

    Ensure-Chocolatey | Out-Null

    $arguments = @(
        'install'
        $Name
        '-y'
        '--no-progress'
    )

    if ($Version) {

        $arguments += @(
            '--version'
            $Version
        )
    }

    if ($Force) {

        $arguments += '--force'
    }

    if ($PSCmdlet.ShouldProcess(
        $Name,
        'Install package'
    )) {

        return Invoke-ChocolateyCommand `
            -Arguments $arguments
    }
}