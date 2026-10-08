[CmdletBinding()]
param(
    [string]$XamppRoot = 'C:\xampp'
)

$ErrorActionPreference = 'Stop'

$configPath = Join-Path $PSScriptRoot 'local\mysql.ini'
$dataPath = Join-Path $PSScriptRoot 'local\mysql-data'
$serverPath = Join-Path $XamppRoot 'mysql\bin\mysqld.exe'

function Test-LocalDatabasePort {
    $client = [System.Net.Sockets.TcpClient]::new()
    try {
        $connection = $client.ConnectAsync('127.0.0.1', 3306)
        if (-not $connection.Wait(300)) {
            return $false
        }

        return $client.Connected
    }
    catch {
        return $false
    }
    finally {
        $client.Dispose()
    }
}

if (-not (Test-Path -LiteralPath $serverPath -PathType Leaf)) {
    throw "No se encontró MariaDB en $serverPath. Instala XAMPP o indica -XamppRoot."
}

if (-not (Test-Path -LiteralPath $configPath -PathType Leaf)) {
    throw "Falta $configPath. Ejecuta primero databases\PrepararBaseLocal.ps1."
}

if (-not (Test-Path -LiteralPath (Join-Path $dataPath 'mysql') -PathType Container)) {
    throw "La instancia local no está inicializada. Ejecuta primero databases\PrepararBaseLocal.ps1."
}

if (Test-LocalDatabasePort) {
    Write-Host 'La base local ya escucha en 127.0.0.1:3306.'
    exit 0
}

$databaseProcess = Start-Process `
    -FilePath $serverPath `
    -ArgumentList "--defaults-file=$configPath", '--console' `
    -WindowStyle Hidden `
    -PassThru

for ($attempt = 1; $attempt -le 20; $attempt++) {
    Start-Sleep -Milliseconds 250

    if (Test-LocalDatabasePort) {
        Write-Host "Base local iniciada en 127.0.0.1:3306 (PID $($databaseProcess.Id))."
        exit 0
    }

    if ($databaseProcess.HasExited) {
        break
    }
}

throw "MariaDB no inició. Revisa databases\local\mysql-error.log."
