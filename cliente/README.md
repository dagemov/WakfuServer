# Cliente de Wakfu

Esta carpeta mantiene el laboratorio del cliente dentro de la raíz del proyecto, separado de la instalación habitual de juego.

La copia local se colocará en `cliente/instalacion/`. Sus binarios, bibliotecas, assets, cachés y registros están excluidos de Git. El repositorio versiona únicamente documentación, configuración permitida, scripts propios y metadatos reproducibles.

La identidad de una copia se registra en `FilesAgents/Cliente.md` mediante versión, build, procedencia, runtime y SHA-256. Si cambia cualquier archivo relevante, se genera un manifiesto nuevo y se explica el motivo.

No se copiará ni modificará un cliente hasta comprobar su versión y preservar la instalación habitual.
