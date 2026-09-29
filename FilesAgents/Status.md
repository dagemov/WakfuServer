# Estado actual

Actualizado: 2026-09-29T07:30:01-04:00 (`America/New_York`)

## Hito

M0 — Viabilidad y elección.

## Último resultado comprobado

- `C:\WakfuServer` quedó vinculado con `origin/main`.
- La comprobación `git push --dry-run` confirmó permiso de escritura sin crear una rama remota.
- La rama de trabajo es `preparar-proyecto`.
- Se creó la jerarquía documental y el plan se trasladó a `FilesAgents/Plan.md`.
- `backend/`, `databases/` y `cliente/` tienen una definición inicial, sin código ni binarios importados.
- Las reglas de Git excluyen instalación, logs, bases locales y respaldos.
- `git diff --check` terminó sin errores.

## Tarea activa

Inventariar el cliente de Wakfu y las herramientas disponibles en la máquina sin modificar la instalación habitual.

## META

Determinar si existe una copia compatible o recuperable del cliente 1.54.0 y conocer qué herramientas ya están disponibles para evaluar WakBox-Evolution.

Criterio de cierre: `Cliente.md` contiene versión, build, procedencia, ruta, runtime y hashes comprobados, o registra con precisión qué dato falta y por qué bloquea la viabilidad.

## CAMBIO previsto

- localizar instalaciones y paquetes de Wakfu sin alterar sus archivos;
- identificar versión, build, runtime y arquitectura;
- calcular hashes únicamente sobre una copia o paquete de laboratorio autorizado;
- inventariar compiladores, Qt, CMake y dependencias ya instaladas;
- registrar evidencia y bloqueos en los documentos vigentes.

## PRUEBA prevista

- las rutas registradas existen;
- las versiones provienen de archivos o salidas observables, no de suposiciones;
- los hashes se pueden repetir;
- ninguna instalación habitual fue modificada;
- no se instaló una herramienta solo para completar la lista.

## Bloqueos y límites

- No se ha verificado todavía un cliente histórico 1.54.0 completo.
- No se ha compilado WakBox-Evolution.
- Git tiene permiso de escritura mediante las credenciales de Windows; el token independiente de GitHub CLI está vencido.

## Siguiente acción exacta

Inspeccionar rutas conocidas de Wakfu y el software de desarrollo instalado; registrar únicamente datos observados en `Cliente.md`.
