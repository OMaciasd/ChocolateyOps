Set-StrictMode -Version Latest

$script:ModuleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Get-ChildItem "$script:ModuleRoot\Private\*.ps1" |
ForEach-Object {
    . $_.FullName
}

Get-ChildItem "$script:ModuleRoot\Public\*.ps1" |
ForEach-Object {
    . $_.FullName
}

Export-ModuleMember -Function @(
    'Initialize-Chocolatey',
    'Get-ChocolateyStatus',
    'Get-ChocolateyOutdatedPackages',
    'Invoke-ChocolateyAutoUpgrade',
    'Invoke-ChocolateyMaintenance',
    'Repair-ChocolateyInstallation'
)