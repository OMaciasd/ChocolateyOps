function Get-ChocoExecutable {

    $paths = @(
        "$env:ProgramData\chocolatey\bin\choco.exe",
        "$env:ChocolateyInstall\bin\choco.exe"
    )

    foreach ($path in $paths) {

        if (Test-Path $path) {
            return $path
        }
    }

    return $null
}

function Test-ChocolateyHealthy {

    try {

        $exe = Get-ChocoExecutable

        if (-not $exe) {
            return $false
        }

        $null = & $exe --version

        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
}