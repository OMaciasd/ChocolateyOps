function Get-ChocolateyStatus {

    [CmdletBinding()]
    param()

    $exe = Get-ChocoExecutable

    [PSCustomObject]@{
        Installed = [bool]$exe
        Healthy   = Test-ChocolateyHealthy
        ExePath   = $exe
        Timestamp = Get-Date
    }
}