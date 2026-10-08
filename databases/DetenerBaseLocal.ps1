[CmdletBinding()]
param(
    [string]$XamppRoot = 'C:\xampp'
)

$ErrorActionPreference = 'Stop'

$adminPath = Join-Path $XamppRoot 'mysql\bin\mysqladmin.exe'

if (-not (Test-Path -LiteralPath $adminPath -PathType Leaf)) {
    throw "No se encontró mysqladmin en $adminPath. Instala XAMPP o indica -XamppRoot."
}

& $adminPath `
    --protocol=TCP `
    --host=127.0.0.1 `
    --port=3306 `
    --user=root `
    shutdown

if ($LASTEXITCODE -ne 0) {
    throw "MariaDB no aceptó la orden de detención (código $LASTEXITCODE)."
}

Write-Host 'Base local detenida.'
