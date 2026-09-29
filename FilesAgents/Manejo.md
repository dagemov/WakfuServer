# Manejo del proyecto

## Al comenzar una sesión

1. Trabajar desde `C:\WakfuServer`; no crear otro checkout.
2. Comprobar rama, estado y cambios locales.
3. Leer `AGENTS.md`, `Status.md` y `Reglas.md`.
4. Leer de `Plan.md` solamente el hito vigente.
5. Confirmar una sola tarea activa con META, CAMBIO y PRUEBA.

## Durante la tarea

1. Inspeccionar antes de modificar.
2. Hacer el cambio mínimo que produzca evidencia para el hito.
3. Mantener cliente, datos y resultados generados dentro de sus carpetas definidas.
4. Ejecutar una prueba proporcional al riesgo.
5. Registrar hechos comprobados en el documento que les corresponde.

Después de dos intentos sin evidencia nueva, se detienen las ediciones. Se anotan las hipótesis consideradas, el resultado de cada intento y el dato que permitiría distinguirlas. El siguiente paso debe obtener ese dato.

## Git

- `main` es la referencia estable.
- Cada tarea coherente utiliza una rama corta con nombre humano, por ejemplo `preparar-proyecto` o `guardar-personaje`.
- Se trabaja en el checkout actual; `git worktree` no forma parte del flujo.
- Antes del commit se revisan `git diff`, `git diff --check` y `git status`.
- El commit incluye el código y la documentación que describen el mismo resultado.
- El mensaje expresa el efecto, por ejemplo `Organiza la documentación inicial del proyecto`.
- El hash, la fecha y el asunto se consultan desde Git. No se modifica el commit para escribir su propio hash dentro de `Status.md`.

## Cierre de la tarea

1. Actualizar META, CAMBIO y PRUEBA con lo ocurrido realmente.
2. Dejar limitaciones y siguiente acción exacta.
3. Crear el commit y publicar la rama.
4. Integrar mediante PR cuando el cambio forme una unidad revisable.
5. Confirmar que ningún archivo local o propietario quedó incluido.

## Respaldos

- Git reemplaza las copias manuales del código y la documentación.
- Los respaldos de bases de datos se guardan en `databases/backups/`, excluidos de Git y con fecha en el nombre.
- El cliente de laboratorio no se respalda en Git. Su identidad se reproduce mediante procedencia, versión y hashes.
