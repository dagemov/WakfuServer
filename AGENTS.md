# Instrucciones de WakfuServer

## Fuente de verdad

- La única raíz de trabajo es `C:\WakfuServer`.
- El remoto oficial es `https://github.com/dagemov/WakfuServer`.
- Trabaja en el checkout actual. No crees worktrees externos ni copias paralelas del proyecto.
- No dejes artefactos persistentes fuera de la raíz. Un archivo temporal del sistema nunca es fuente de verdad.

## Inicio de cada sesión

1. Ejecuta `git status --short --branch` y comprueba la rama y los cambios locales.
2. Lee `FilesAgents/Status.md`, `FilesAgents/Reglas.md` y `FilesAgents/Manejo.md`.
3. Consulta en `FilesAgents/Plan.md` únicamente el hito activo.
4. Lee `Cliente.md`, `Protocolo.md` o el código solo cuando la tarea los necesite.
5. Conserva cualquier cambio del usuario y detente si se superpone con la tarea.

## Orden de trabajo

- Mantén una sola tarea activa en `Status.md`.
- Expresa cada tarea con META, CAMBIO y PRUEBA.
- Completa primero M0 y sus puertas de viabilidad; no programes funciones de hitos posteriores para ocultar un bloqueo.
- Tras dos intentos sin evidencia nueva, documenta hipótesis, resultados y el dato que falta. Diseña una prueba distinta antes de editar más.
- No marques una integración como terminada sin prueba con el cliente real. Usa `VERIFICACIÓN PENDIENTE` cuando corresponda.

## Estructura y nombres

- `backend/` contiene únicamente el servidor y conserva la estructura útil del candidato importado.
- `databases/` contiene definiciones versionables y respaldos locales según su propio README.
- `cliente/` contiene instrucciones y el laboratorio local del cliente según su propio README.
- No inventes capas, carpetas o patrones por apariencia. Cada carpeta debe responder a una responsabilidad real.
- Usa nombres humanos y completos. Evita `Manager2`, `NewSystem`, `FinalFix`, `Utils` genérico y abreviaturas inventadas.
- Documentos, commits y explicaciones van en español. El código nuevo sigue el idioma y las convenciones del módulo donde vive.

## Evidencia y seguridad

- Distingue evidencia ejecutada, evidencia estática, hipótesis y pendiente.
- No inventes compatibilidad, paquetes, hashes, resultados ni identificadores del protocolo.
- No publiques cliente, assets, credenciales, tickets, registros crudos, volcados de base de datos ni binarios generados.
- La instalación habitual de juego permanece separada del laboratorio.
- Conserva la procedencia, revisión original y condiciones de licencia de cualquier código incorporado.

## Cierre de una tarea

1. Ejecuta las pruebas relevantes y registra el resultado real.
2. Actualiza `Status.md` y solo la documentación afectada.
3. Revisa `git diff`, `git diff --check` y `git status`.
4. Crea un commit coherente con mensaje humano.
5. Obtén hash, fecha y asunto desde Git; no escribas en un archivo el hash del commit que lo contiene.
6. Publica la rama conforme a `Manejo.md` y deja una siguiente acción exacta.
