Set-StrictMode -Version Latest

$script:ModuleRoot = Split-Path `
    -Parent `
    $MyInvocation.MyCommand.Path

Get-ChildItem `
    -Path "$script:ModuleRoot\Private\*.ps1" |
ForEach-Object {

    . $_.FullName
}

$publicFunctions = Get-ChildItem `
    -Path "$script:ModuleRoot\Public\*.ps1"

$publicFunctions | ForEach-Object {

    . $_.FullName
}

Export-ModuleMember -Function (
    $publicFunctions |
    Select-Object -ExpandProperty BaseName
)