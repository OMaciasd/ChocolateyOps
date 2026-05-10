function Get-ChocolateyOutdatedPackages {

    [CmdletBinding()]
    param()

    $exe = Get-ChocoExecutable

    if (-not $exe) {
        throw 'Chocolatey not installed.'
    }

    choco outdated --limit-output |
    ForEach-Object {

        $parts = $_ -split '\|'

        [PSCustomObject]@{
            Package          = $parts[0]
            CurrentVersion   = $parts[1]
            AvailableVersion = $parts[2]
        }
    }
}