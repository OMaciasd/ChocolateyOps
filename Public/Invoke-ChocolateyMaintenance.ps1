function Invoke-ChocolateyMaintenance {

    [CmdletBinding()]
    param()

    return [PSCustomObject]@{
        StatusBefore = Get-ChocolateyStatus
        Upgrade      = Invoke-ChocolateyAutoUpgrade -RepairIfUnhealthy
        StatusAfter  = Get-ChocolateyStatus
    }
}