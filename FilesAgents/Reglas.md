# Reglas del proyecto

## Fuentes de verdad

1. La raíz local es `C:\WakfuServer`.
2. El remoto oficial es `https://github.com/dagemov/WakfuServer`.
3. El contenido local puede estar por delante del último commit; siempre se revisan estado y diff.
4. `Plan.md` contiene las metas estables y `Status.md` contiene el presente.
5. Git conserva el historial. No se crean variantes `v2`, `final`, copias fechadas del proyecto ni diarios acumulativos.

## Artefactos y checkouts

- Todo resultado persistente del proyecto vive dentro de `C:\WakfuServer`.
- No se usan worktrees externos, repositorios paralelos ni carpetas de entrega fuera de la raíz.
- Los archivos temporales creados por herramientas no son fuentes de verdad y se eliminan o regeneran.
- El checkout actual es el único espacio de trabajo. Las ramas cortas proporcionan aislamiento lógico.

## Arquitectura comprensible

- La raíz técnica se divide en `backend/`, `databases/` y `cliente/`.
- Una subcarpeta se crea cuando existe una responsabilidad y contenido reales.
- No se imponen capas genéricas como `Core`, `Common`, `Services` o `Infrastructure` sin una necesidad demostrada en el código.
- Al incorporar WakBox-Evolution se conserva su estructura interna útil y se documentan los cambios; no se ejecuta un renombrado masivo.
- Las pruebas se ubican junto al módulo si así trabaja el candidato. Solo se crea una raíz `pruebas/` si hay pruebas transversales reales.
- Los scripts repetibles se guardan en `herramientas/` cuando aparezca el primero; no se crea la carpeta vacía.

## Capas y principios SOLID

- La arquitectura limpia se aplica por dirección de dependencias: dominio, aplicación, entrada/salida, infraestructura y composición.
- El dominio contiene reglas del juego y no conoce Qt Network, Qt Sql, MySQL, archivos de configuración ni detalles de paquetes.
- La aplicación coordina casos de uso con contratos pequeños que nacen de una necesidad comprobada.
- Las sesiones y manejadores convierten mensajes del cliente en solicitudes de aplicación; no concentran reglas de negocio nuevas.
- La infraestructura implementa red, persistencia, criptografía, serialización, compresión, configuración y lectura de datos.
- `authserver` y `worldserver` son puntos de composición y arranque. No se usan como depósitos de lógica compartida.
- SOLID guía cada cambio tocado. No obliga a crear una interfaz por clase, fábricas sin variantes ni una jerarquía paralela al código histórico.
- Una extracción debe nombrar la responsabilidad que separa y tener una prueba o un consumidor real. No se crean carpetas vacías para representar el diagrama.
- Durante M0 y la primera reproducción se conserva la estructura útil del candidato. Las separaciones se realizan de forma incremental después de establecer una referencia compilable.

## Backend

- Antes de importar código se registra repositorio, commit, método de incorporación y licencia o bloqueo de licencia.
- No se anida otro repositorio `.git` dentro de `backend/`.
- Código nuevo sigue las convenciones del módulo existente.
- Cada componente debe tener un propósito observable dentro del hito activo.
- El perfil de reproducción parte de qmake, Qt 5 Core/Network/Sql, MySQL, Protocol Buffers, Crypto++, QuaZip y el compilador compatible que demuestre la primera compilación.
- Una actualización de toolchain se prueba por separado de los cambios de protocolo o comportamiento.

## Bases de datos y respaldos

- Se versionan esquemas, migraciones, configuración de ejemplo y datos de prueba no sensibles.
- Las bases locales, volcados y respaldos viven bajo `databases/` pero están excluidos de Git.
- Los respaldos usan `AAAA-MM-DD_HH-mm_descripcion.ext`; la fecha indica cuándo se creó la copia.
- No se crean respaldos automáticos por cada edición. Se genera uno antes de una migración o cambio destructivo que realmente lo justifique.
- Un respaldo debe indicar qué base contiene y cómo restaurarlo, sin credenciales incluidas.

## Cliente de Wakfu

- La copia de laboratorio vive bajo `cliente/instalacion/`; nunca se modifica la instalación habitual para resolver un experimento.
- Git no versiona ejecutables, bibliotecas, assets, cachés ni datos propietarios del cliente.
- `Cliente.md` registra versión, build, procedencia, SHA-256, runtime, sistema y configuración comprobada.
- Un cambio de archivos del cliente exige volver a calcular hashes y explicar por qué cambió.
- Nunca se usan credenciales oficiales en el laboratorio.

## Nombres humanos

- Un nombre explica una responsabilidad: `CharacterRepository`, `CreateCharacterHandler` o `CharacterAppearance` cuando esas responsabilidades existan.
- Se evitan nombres como `Manager2`, `NewSystem`, `FinalFix`, `UltraEngine`, `Misc` y `Utils` sin ámbito.
- Documentos, mensajes de commit y explicaciones se escriben en español.
- No se traducen identificadores históricos del candidato solo por preferencia estética.

## Evidencia y alcance

- Etiquetas válidas: `EJECUTADO`, `EVIDENCIA ESTÁTICA`, `HIPÓTESIS` y `PENDIENTE`.
- Compilar no demuestra conexión; una simulación no demuestra integración con el cliente.
- Si Sebastián no realizó una comprobación visual necesaria, se registra `VERIFICACIÓN PENDIENTE`.
- No se amplía el alcance para evitar un bloqueo del hito activo.
- No se publican secretos, tickets, logs crudos, capturas de red con datos sensibles ni material sin permiso de redistribución.
