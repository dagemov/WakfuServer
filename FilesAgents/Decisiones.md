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
