# Decisiones

## D-001 — Raíz única

- Fecha: 2026-09-26.
- Estado: aceptada.
- Decisión: `C:\WakfuServer` es la única raíz local y fuente de verdad operativa.
- Razón: evitar copias divergentes y rutas difíciles de comprender.

## D-002 — Repositorio oficial público

- Fecha: 2026-09-29.
- Estado: comprobada.
- Decisión: el remoto oficial es `https://github.com/dagemov/WakfuServer`, con `main` como rama estable.
- Consecuencia: cliente, assets, credenciales, respaldos y evidencia sensible quedan fuera de Git.

## D-003 — Candidato inicial

- Fecha: 2026-09-26.
- Estado: condicionada a M0.
- Decisión: evaluar primero WakBox-Evolution con el cliente 1.54.0.
- Evidencia: el README y rutas estáticas inspeccionadas declaran esa versión y contienen manejo de creación y entrada al mundo.
- Condición de revisión: cliente no disponible, compilación inviable, licencia incompatible o bloqueo técnico documentado.

## D-004 — Lenguaje inicial

- Fecha: 2026-09-26.
- Estado: aceptada.
- Decisión: conservar C++/Qt del candidato; no portar a Java antes de demostrar el recorrido inicial.
- Razón: el lenguaje del cliente no obliga al servidor y una reescritura aumenta el tiempo hasta la primera evidencia.

## D-005 — Jerarquía técnica

- Fecha: 2026-09-29.
- Estado: aceptada.
- Decisión: usar `backend/`, `databases/` y `cliente/` como áreas técnicas principales.
- Regla: las subcarpetas aparecen por responsabilidades reales, no para imponer una arquitectura genérica.

## D-006 — Sin artefactos o worktrees externos

- Fecha: 2026-09-29.
- Estado: aceptada.
- Decisión: todo resultado persistente vive dentro de la raíz y se trabaja en un único checkout.
- Consecuencia: el aislamiento se realiza con ramas cortas; los archivos locales se excluyen mediante Git.

## D-007 — Documentación vigente en el mismo lugar

- Fecha: 2026-09-26.
- Estado: aceptada.
- Decisión: no crear variantes por fecha o versión. `Plan.md` y `Status.md` se actualizan en su ubicación estable y Git conserva el historial.

## D-008 — Frameworks y perfil inicial de compilación

- Fecha: 2026-10-07.
- Estado: aceptada para reproducción; versiones por validar al compilar.
- Decisión: el primer intento conserva C++ y el sistema de proyectos qmake de WakBox-Evolution. El backend usa Qt 5 con los módulos Core, Network y Sql; Qt Test será la primera opción cuando exista una prueba automatizada que aporte evidencia.
- Persistencia: MySQL mediante el controlador `QMYSQL` de Qt. Los esquemas y cambios versionables viven en `databases/` y las credenciales permanecen en configuración local ignorada.
- Dependencias observadas: Protocol Buffers 3.2.0, Crypto++ 5.6.3 y QuaZip. La versión exacta de QuaZip sigue pendiente. No se actualizará una dependencia durante M0 solo para ocultar un fallo de reproducción.
- Perfil histórico observado: los archivos del candidato mencionan Qt 5.0.2 y Qt 5.8.0 con MinGW de 32 bits. Esto guía la primera reproducción, pero no constituye todavía una compilación aprobada.
- Herramientas posteriores: CMake, otro compilador o una versión distinta de Qt requieren primero una compilación de referencia y una decisión con prueba equivalente. No se harán una migración de build y una corrección de protocolo en el mismo cambio.

## D-009 — Arquitectura por capas, limpia y SOLID

- Fecha: 2026-10-07.
- Estado: aceptada.
- Decisión: el backend evolucionará con dependencias dirigidas hacia las reglas del juego. Las capas son responsabilidades lógicas y no justifican por sí solas carpetas nuevas.
- Dominio: entidades y reglas del mundo sin acceso directo a red, SQL, archivos o configuración.
- Aplicación: casos de uso como autenticar, crear personaje, seleccionar personaje y entrar al mundo; coordina puertos definidos por la necesidad real.
- Entrada y salida: sesiones, paquetes y manejadores traducen el protocolo hacia los casos de uso.
- Infraestructura: Qt Network, Qt Sql, MySQL, criptografía, Protocol Buffers, compresión, configuración y lectura de datos implementan los bordes externos.
- Composición: `authserver` y `worldserver` crean dependencias e inician los procesos.
- Regla de adopción: se conserva primero la estructura útil del candidato. Al modificar un recorrido se separa únicamente el acoplamiento necesario para probarlo. No habrá una reorganización masiva ni capas vacías.
- Principios: responsabilidad única, extensiones mediante contratos concretos, sustitución comprobada, interfaces pequeñas e inversión de dependencias en los límites que necesiten prueba o reemplazo. Se evita crear interfaces para clases que no tienen un segundo uso o un borde externo.

## D-010 — Obtención y versionado del cliente

- Fecha: 2026-10-07.
- Estado: aceptada; obtención 1.54.0 pendiente.
- Decisión: solo se acepta un cliente histórico completo cuando su versión/build, procedencia y hash se puedan verificar. Se prefieren el CDN oficial de Ankama, una captura verificable de una distribución oficial o un depósito de Steam identificado.
- Laboratorio: la descarga autorizada se guarda en `cliente/instalacion/`, separada de las instalaciones habituales y excluida de Git.
- Publicación: el repositorio conserva metadatos, hashes e instrucciones propias; no publica el cliente, sus assets ni un enlace de origen dudoso.
- Resultado actual: la página oficial archivada de 2017 confirma la ruta de descarga usada entonces, pero no se encontró una captura del cliente completo de junio de 2017 ni el identificador exacto de su build. Un instalador archivado en noviembre de 2017 corresponde a una fecha posterior y no demuestra compatibilidad 1.54.0.

## D-011 — Publicación del código candidato

- Fecha: 2026-10-07.
- Estado: bloqueada.
- Decisión: no se copiará WakBox-Evolution a `backend/` mientras no exista una licencia de reutilización comprobable o permiso explícito del titular.
- Evidencia: el árbol inspeccionado en el commit `bacde4702ed871c639ea81f2179f1619beb42c0b` no contiene un archivo general `LICENSE`, `COPYING` o `NOTICE`.
- Consecuencia: durante M0 se puede documentar su comportamiento público y probar una obtención local no publicada conforme a sus condiciones, pero el repositorio público no incorporará sus fuentes sin resolver esta puerta.

## D-012 — Resultado provisional de M0

- Fecha: 2026-10-07.
- Estado: NO-GO temporal.
- WakBox-Evolution: es el candidato funcional más cercano al objetivo, pero falla las puertas de cliente verificable y licencia de reutilización. Tampoco existe todavía un toolchain local para compilarlo.
- WakSharp: tiene licencia MIT y código real para autenticación, lista y persistencia de personajes con MySQL, pero apunta al cliente 1.28.2, depende de binarios históricos no restaurables desde su proyecto y no implementa la selección de personaje ni la entrada al mapa.
- Decisión: no importar ninguno ni programar funciones de M1–M5 para aparentar avance. M0 se reabre cuando exista una combinación cliente/build verificable y una base con permiso de uso, o cuando se apruebe explícitamente un alcance nuevo con estimación propia.
- Razón: el plan exige probar como máximo dos candidatos y declarar el bloqueo si ninguno supera las puertas obligatorias.

## D-013 — Base de datos local de laboratorio

- Fecha: 2026-10-07.
- Estado: aceptada para M0.
- Decisión: usar MariaDB 10.4.32 de XAMPP como instancia local compatible con MySQL y el controlador `QMYSQL` observado en WakBox-Evolution.
- Aislamiento: escucha únicamente en `127.0.0.1:3306`; los datos activos, registros y configuración real viven en `databases/local/` y están excluidos de Git.
- Reproducción: `PrepararBaseLocal.ps1`, `IniciarBaseLocal.ps1` y `DetenerBaseLocal.ps1` controlan la instancia; `schema/001_create_databases.sql` define las tres bases iniciales.
- Navicat: el perfil comprobado se llama `WakfuServer local`. Durante M0 usa `root` sin contraseña en loopback; antes de integrar o exponer el backend se creará un usuario propio con una credencial local no versionada.
