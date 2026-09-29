# Bases de datos

Esta carpeta agrupa el material de base de datos del servidor.

Cuando sean necesarios se crearán directorios con responsabilidades reales:

- `schema/`: definición reproducible del esquema inicial;
- `migrations/`: cambios ordenados del esquema;
- `test-data/`: datos mínimos no sensibles para pruebas;
- `backups/`: copias locales antes de cambios destructivos.

`backups/` no se versiona. Cada archivo usa el formato `AAAA-MM-DD_HH-mm_descripcion.ext` e incluye instrucciones de restauración fuera del propio volcado. Git no almacena bases activas, dumps, credenciales ni copias periódicas sin propósito.
