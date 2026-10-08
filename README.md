# WakfuServer

Proyecto de investigación y desarrollo de `Wakfu-RevolutionEmu`, un emulador propio para reproducir un recorrido local y controlado con un cliente de Wakfu: crear un personaje, seleccionarlo, entrar a un mapa y conservarlo después de reiniciar cliente y servidor.

## Estado actual

El proyecto está en **M0 — Especificación, cliente y elección**. WakBox-Evolution es la referencia principal de auditoría y 1.54.0 es el cliente preferido, pero todavía falta una distribución verificable. El producto no tiene aún lenguaje o frameworks fijados.

## Orden del repositorio

- `FilesAgents/`: plan, estado, reglas, decisiones y evidencia técnica.
- `backend/`: código propio del servidor; se inicia después de cerrar las puertas de M0.
- `databases/`: esquemas, migraciones, datos de prueba y respaldos locales cuando sean necesarios.
- `cliente/`: definición del laboratorio del cliente. Sus binarios y recursos no se publican.

El detalle del hito actual está en [FilesAgents/Status.md](FilesAgents/Status.md). Las condiciones de aceptación están en [FilesAgents/Plan.md](FilesAgents/Plan.md).

## Alcance inicial

Una cuenta local debe poder crear un personaje, seleccionarlo, entrar a un mapa con apariencia correcta y recuperarlo tras reiniciar. El recorrido se repetirá tres veces y se comprobará aislamiento con una segunda cuenta.

Combate, economía, oficios, todas las clases, launcher propio, panel web y despliegue público quedan fuera del primer objetivo.

## Estado de las instrucciones

Los procedimientos de preparación, compilación y ejecución se escribirán aquí únicamente después de ser comprobados. No se presenta todavía ningún comando de arranque como válido.

## Contenido no publicado

El repositorio no almacena el cliente de Wakfu, assets propietarios, credenciales, registros crudos, respaldos de bases de datos ni binarios generados. Git conserva la información reproducible permitida: versiones, hashes, configuración de ejemplo, código propio y documentación.
