Set-StrictMode -Version Latest

function Get-ChocoExecutable {

    [CmdletBinding()]
    param()

    $paths = @(
        "$env:ProgramData\chocolatey\bin\choco.exe",
        "$env:ChocolateyInstall\bin\choco.exe"
    )

    foreach ($path in $paths) {

        if ([string]::IsNullOrWhiteSpace($path)) {
            continue
        }

        if (Test-Path -Path $path) {
            return $path
        }
    }

    return $null
}

function Test-ChocolateyInstalled {

    [CmdletBinding()]
    param()

    return $null -ne (Get-ChocoExecutable)
}

function Get-ChocolateyVersion {

    [CmdletBinding()]
    param()

    $exe = Get-ChocoExecutable

    if (-not $exe) {
        return $null
    }

    try {

        $version = & $exe --version 2>$null

        if ($LASTEXITCODE -ne 0) {
            return $null
        }

        return ($version | Select-Object -First 1)
    }
    catch {
        return $null
    }
}

function Test-ChocolateyHealthy {

    [CmdletBinding()]
    param()

    try {

        $version = Get-ChocolateyVersion

        return -not [string]::IsNullOrWhiteSpace($version)
    }
    catch {
        return $false
    }
}