# Bases de datos

Esta carpeta agrupa el material de base de datos del servidor.

Cuando sean necesarios se crearán directorios con responsabilidades reales:

- `schema/`: definición reproducible del esquema inicial;
- `migrations/`: cambios ordenados del esquema;
- `test-data/`: datos mínimos no sensibles para pruebas;
- `backups/`: copias locales antes de cambios destructivos.

`backups/` no se versiona. Cada archivo usa el formato `AAAA-MM-DD_HH-mm_descripcion.ext` e incluye instrucciones de restauración fuera del propio volcado. Git no almacena bases activas, dumps, credenciales ni copias periódicas sin propósito.

## Instancia local para Navicat

El laboratorio usa el servidor MariaDB 10.4.32 incluido en XAMPP, compatible con el protocolo MySQL y con el controlador `QMYSQL` del candidato.

- Host: `127.0.0.1`.
- Puerto: `3306`.
- Datos locales: `C:\WakfuServer\databases\local\mysql-data`.
- Configuración de referencia: `config/mysql.local.example.ini`.
- Bases iniciales: `wakbox_auth`, `wakbox_char` y `wakbox_world`.
- Definición reproducible: `schema/001_create_databases.sql`.

Desde la raíz del repositorio:

```powershell
.\databases\PrepararBaseLocal.ps1
.\databases\IniciarBaseLocal.ps1
.\databases\DetenerBaseLocal.ps1
```

`PrepararBaseLocal.ps1` es idempotente: crea la configuración ignorada, inicializa los datos si faltan, inicia MariaDB y aplica las bases iniciales. Los otros dos comandos controlan la instancia después de esa preparación.

La conexión comprobada de Navicat se llama `WakfuServer local` y usa `localhost:3306`, usuario `root` y contraseña vacía. Este acceso inicial se acepta solo para el laboratorio M0 porque el servidor escucha únicamente en loopback. Antes de exponer un servicio o incorporar el backend se creará un usuario propio con credencial local ignorada. El perfil que guarda Navicat y cualquier contraseña futura no se escriben en Git.
