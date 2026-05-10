@{
    RootModule        = 'ChocolateyOps.psm1'
    ModuleVersion     = '1.4.0'
    GUID              = 'e7b9c8aa-fd93-4a91-9b7d-99801ddcb100'

    Author            = 'OpenAI'
    CompanyName       = 'OpenAI'
    Copyright         = '(c) OpenAI'

    Description       = 'Production-grade Chocolatey lifecycle automation module.'

    PowerShellVersion = '5.1'

    FunctionsToExport = @(
        'Initialize-Chocolatey',
        'Get-ChocolateyStatus',
        'Get-ChocolateyOutdatedPackages',
        'Invoke-ChocolateyAutoUpgrade',
        'Invoke-ChocolateyMaintenance',
        'Repair-ChocolateyInstallation'
    )

    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
}