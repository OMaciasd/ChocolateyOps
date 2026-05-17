Set-StrictMode -Version Latest

function Write-ChocolateyOpsLog {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $Message,

        [ValidateSet(
            'INFO',
            'WARN',
            'ERROR',
            'DEBUG'
        )]
        [string]
        $Level = 'INFO'
    )

    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

    Write-Host "[$timestamp] [$Level] $Message"
}