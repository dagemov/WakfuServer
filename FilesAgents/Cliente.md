# Cliente de laboratorio

## Estado

`PENDIENTE`: las instalaciones actuales están inventariadas, pero todavía no existe una copia completa y verificable del cliente 1.54.0 en `cliente/instalacion/`.

La inspección fue de solo lectura. No se modificaron las instalaciones administradas por Ankama Launcher.

## Objetivo preferido

- Versión preferida: 1.54.0.
- Referencia principal: WakBox-Evolution.
- Sistema: Windows del PC de Sebastián.
- Ruta autorizada para la copia de laboratorio: `C:\WakfuServer\cliente\instalacion`.
- Instalación habitual: se mantiene separada y no se modifica.

## Instalaciones actuales observadas

Estas copias sirven para inventariar el equipo. No son compatibles con el candidato 1.54.0.

| Dato | Canal principal | Canal beta |
|---|---|---|
| Ruta | `C:\Users\Hombr\AppData\Local\Ankama\Wakfu` | `C:\Users\Hombr\AppData\Local\Ankama\Wakfu-beta` |
| Canal | `main` | `beta` |
| Build anunciado por el índice oficial al inspeccionar | `6.0_1.93.1.5303.333` | `6.0_1.93.0.5236.104` |
| Runtime incluido | Temurin OpenJDK `21.0.12+8`, 64 bits | Temurin OpenJDK `21.0.12+8`, 64 bits |
| `wakfu-client.jar` | 34.009.442 bytes | 33.997.276 bytes |
| SHA-256 de `wakfu-client.jar` | `7DD7003AEB0BFB0DC7EE94B6C1A579C5D8FC93E35DD4BA416A0275925F15BEF5` | `A9E838F74794DB89409E527D09B76BCE66C393C09B8761ED8B7F9743FB31FFA1` |
| SHA-256 de `manifest.json` | `ED5318D83DAA0D37E240681893AC9D92AAC11C33EF2EE4FD69BD14668C690362` | `080976B9ECB06BA439881C928E3238656F63F302EB72B11FAFC60EAA490B2ED2` |

Evidencia ejecutada el 7 de octubre de 2026: rutas, archivos, runtime y hashes se leyeron directamente del equipo; los builds se consultaron en `https://cytrus.cdn.ankama.com/cytrus.json`.

## Cliente histórico 1.54.0

| Dato requerido | Resultado actual |
|---|---|
| Versión visible | `1.54.0` declarada por WakBox-Evolution; paquete pendiente |
| Build interno | Pendiente |
| Procedencia | Pendiente de una distribución verificable |
| SHA-256 del paquete o manifiesto | Pendiente porque el paquete no está disponible |
| Runtime Java | Pendiente; debe leerse de la distribución obtenida |
| Arquitectura | Pendiente; no se inferirá desde clientes actuales |
| Fecha de obtención | Pendiente |
| Configuración del destino | Pendiente de inspección sobre la copia de laboratorio |

### Intentos y resultados

1. `EJECUTADO`: se consultó el índice actual del CDN de Ankama. Solo anuncia los builds actuales 1.93 para `main` y `beta`; no ofrece un catálogo histórico.
2. `EJECUTADO`: se probaron nombres simples de manifiesto para `1.54.0`, `1.54.0.0`, `1.54` y `1.54.0_0`. El CDN respondió `403`, resultado que no identifica un build válido.
3. `EVIDENCIA ESTÁTICA`: una captura del 27 de mayo de 2017 de la página oficial de Wakfu enlaza `http://download.wakfu.com/full/win/`.
4. `EJECUTADO`: el índice de Internet Archive no contiene una captura de esa distribución durante junio o julio de 2017. La redirección recuperable apunta a `wakfu.exe` archivado el 25 de noviembre de 2017, posterior a las versiones 1.55 y 1.56; no prueba compatibilidad 1.54.0.
5. `EJECUTADO`: una búsqueda de elementos públicos de Internet Archive por Wakfu 1.54/2017 no produjo un paquete candidato.
6. `EVIDENCIA ESTÁTICA`: el commit de WakBox-Evolution `2ee6535fa9af83a7f66bf6eb62af354801015a67`, fechado el 28 de junio de 2017, declara la actualización del servidor a 1.54.0, pero no incluye ni enlaza el cliente.
7. `EJECUTADO`: el historial público visible de Steam/SteamDB no expone manifiestos de junio de 2017 sin autenticación. Los depósitos visibles corresponden al launcher, archivos actuales o contenido posterior y no identifican 1.54.0.
8. `EJECUTADO`: no apareció un paquete histórico con nombre Wakfu en Descargas, Escritorio, Documentos ni en las carpetas superficiales de los discos locales. Solo se encontró la raíz actual del proyecto.
9. `EVIDENCIA ESTÁTICA`: la publicación oficial conservada por Steam confirma que la actualización 1.54 salió el 26 de junio de 2017. La búsqueda actual sigue sin revelar un paquete, build o manifiesto descargable y verificable de esa fecha.

`DATO FALTANTE`: identificador completo de build, manifiesto o paquete del cliente 1.54.0 cuya procedencia se pueda demostrar. Sin ese dato no se puede descargar, verificar ni ejecutar la ruta preferida.

`PRUEBA DISTINTA SIGUIENTE`: localizar un manifiesto histórico identificado en un depósito oficial/Steam o conseguir del mantenedor la identidad exacta de la distribución. Solo entonces se descargará en `cliente/instalacion/` y se calcularán sus hashes sin usar credenciales oficiales.

## Alternativa histórica comprobada

WakSharp declara y valida el cliente 1.28.2. Su licencia MIT permite evaluar el código, pero no se encontró una distribución verificable de ese cliente. Además, la fuente inspeccionada no contiene el recorrido de selección y entrada al mapa. Por ello tampoco forma una combinación viable para continuar a M1.

## Herramientas observadas

| Herramienta | Evidencia | Consecuencia |
|---|---|---|
| Git | 2.52.0.1 | Disponible |
| Visual Studio Community | 2022 17.14.26 y 2026 18.9.1 | Instalados sin evidencia de la carga C++/CMake requerida |
| Java global | Oracle Java 8 `8.0.202.8` | No sustituye el runtime del cliente objetivo |
| `javac` | No encontrado | No requerido para compilar el servidor C++ |
| .NET SDK | 9.0.311, 10.0.201, 10.0.400 y 11 preliminar | Permitiría evaluar Cytrus si aparece el build exacto |
| Qt/qmake | No encontrado | Bloquea la compilación actual del candidato |
| MinGW o MSVC C++ | No encontrado como toolchain utilizable | Bloquea la compilación actual del candidato |
| CMake/Ninja | No encontrados | No son requisito del qmake histórico, pero tampoco están disponibles |

No se instaló ninguna herramienta para completar el inventario.

## Regla de versionado

El binario y los assets del cliente no se guardan en Git. La versión reproducible se identifica mediante procedencia, versión, build, hashes y un manifiesto local. Cualquier modificación del laboratorio debe describirse y producir hashes nuevos.

Los registros, cachés, capturas y archivos temporales del cliente permanecen bajo `cliente/` en rutas ignoradas por Git.
