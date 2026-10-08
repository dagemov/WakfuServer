[CmdletBinding()]
param(
    [string]$XamppRoot = 'C:\xampp'
)

$ErrorActionPreference = 'Stop'

$exampleConfigPath = Join-Path $PSScriptRoot 'config\mysql.local.example.ini'
$localDirectory = Join-Path $PSScriptRoot 'local'
$configPath = Join-Path $localDirectory 'mysql.ini'
$dataPath = Join-Path $localDirectory 'mysql-data'
$installerPath = Join-Path $XamppRoot 'mysql\bin\mysql_install_db.exe'
$clientPath = Join-Path $XamppRoot 'mysql\bin\mysql.exe'
$schemaPath = Join-Path $PSScriptRoot 'schema\001_create_databases.sql'

foreach ($requiredFile in @($exampleConfigPath, $installerPath, $clientPath, $schemaPath)) {
    if (-not (Test-Path -LiteralPath $requiredFile -PathType Leaf)) {
        throw "Falta el archivo requerido: $requiredFile"
    }
}

New-Item -ItemType Directory -Path $localDirectory -Force | Out-Null

if (-not (Test-Path -LiteralPath $configPath -PathType Leaf)) {
    Copy-Item -LiteralPath $exampleConfigPath -Destination $configPath
    Write-Host "Configuración local creada en $configPath."
}

if (-not (Test-Path -LiteralPath (Join-Path $dataPath 'mysql') -PathType Container)) {
    New-Item -ItemType Directory -Path $dataPath -Force | Out-Null
    & $installerPath --datadir=$dataPath --port=3306 --silent

    if ($LASTEXITCODE -ne 0) {
        throw "No se pudo inicializar MariaDB (código $LASTEXITCODE)."
    }

    Write-Host "Datos locales inicializados en $dataPath."
}

& (Join-Path $PSScriptRoot 'IniciarBaseLocal.ps1') -XamppRoot $XamppRoot

Get-Content -LiteralPath $schemaPath -Raw |
    & $clientPath --protocol=TCP --host=127.0.0.1 --port=3306 --user=root

if ($LASTEXITCODE -ne 0) {
    throw "No se pudo aplicar $schemaPath (código $LASTEXITCODE)."
}

Write-Host 'Bases wakbox_auth, wakbox_char y wakbox_world disponibles.'
