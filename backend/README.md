# Backend

Esta carpeta alojará el código del servidor seleccionado después de superar las puertas de M0.

Antes de incorporar código se debe registrar:

- repositorio y commit exactos de origen;
- licencia o bloqueo de licencia;
- procedimiento de importación;
- toolchain y dependencias;
- componentes que participan en autenticación, selección, creación y mundo.

No se anidará otro directorio `.git`. La estructura interna del candidato se conservará cuando represente responsabilidades reales. No se crearán capas vacías ni se renombrará masivamente el proyecto.

## Perfil técnico inicial

La reproducción de WakBox-Evolution parte de su combinación observada:

- C++ con proyectos qmake;
- Qt 5: Core, Network y Sql;
- MySQL mediante el controlador `QMYSQL`;
- Protocol Buffers 3.2.0;
- Crypto++ 5.6.3;
- QuaZip, con versión exacta todavía pendiente.

Los rastros de compilación del repositorio mencionan Qt 5.0.2 y Qt 5.8.0 con MinGW de 32 bits. Estas versiones describen el entorno histórico; la combinación instalable se aprobará solo cuando compile y arranque de forma repetible.

## Capas que guían los cambios

La arquitectura se aplica sobre responsabilidades reales del candidato:

| Capa | Responsabilidad | Ubicación histórica aproximada |
|---|---|---|
| Dominio | Personajes, criaturas, objetos y reglas del mundo | `worldserver/Game/Entities` y reglas asociadas |
| Aplicación | Autenticar, crear, seleccionar y entrar al mundo | coordinación que hoy aparece entre sesiones y manejadores |
| Entrada y salida | Sesiones, opcodes, paquetes y traducción del protocolo | `authserver`, `worldserver/Game/Handlers` y `Server/Protocol` |
| Infraestructura | Red, MySQL, configuración, criptografía, Protobuf, QuaZip y datos de mapas | `shared` y lectores concretos de `worldserver/Game/Maps` |
| Composición | Construcción de dependencias y ciclo de vida de procesos | entradas de `authserver` y `worldserver` |

La dirección deseada es hacia dominio y aplicación. La tabla no ordena mover archivos de inmediato. Cada recorrido que se modifique separará el mínimo acoplamiento necesario y conservará nombres históricos mientras sigan explicando su responsabilidad.

## Puerta antes de importar

El commit inspeccionado del candidato es `bacde4702ed871c639ea81f2179f1619beb42c0b`. Su árbol no contiene una licencia general comprobable, por lo que no se copiará al repositorio público hasta obtener permiso de reutilización o seleccionar una base con licencia compatible.
