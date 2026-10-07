# Cliente de Wakfu

Esta carpeta mantiene el laboratorio del cliente dentro de la raíz del proyecto, separado de la instalación habitual de juego.

La copia local se colocará en `cliente/instalacion/`. Sus binarios, bibliotecas, assets, cachés y registros están excluidos de Git. El repositorio versiona únicamente documentación, configuración permitida, scripts propios y metadatos reproducibles.

La identidad de una copia se registra en `FilesAgents/Cliente.md` mediante versión, build, procedencia, runtime y SHA-256. Si cambia cualquier archivo relevante, se genera un manifiesto nuevo y se explica el motivo.

La descarga del cliente compatible está autorizada para el laboratorio. Solo se acepta una fuente cuya versión, build y procedencia puedan verificarse; después se calculan hashes antes de modificar cualquier configuración. La instalación habitual nunca se usa como espacio de prueba.

El repositorio público no contiene el cliente ni sus assets. `FilesAgents/Cliente.md` conserva los intentos de obtención, los bloqueos y la identidad reproducible de la copia cuando exista.
