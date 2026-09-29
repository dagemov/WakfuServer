# Plan operativo: crear un personaje y entrar al mundo

Fecha de investigación: 26 de septiembre de 2026.
Estado: M0 en ejecución, con inspección estática parcial de fuentes públicas. Ningún emulador se ha compilado o conectado a un cliente.

## Objetivo y alcance

Terminar cuando, desde una instalación reproducible, una cuenta local de prueba pueda crear un personaje desde la interfaz del cliente elegido, seleccionarlo, entrar en un mapa con apariencia correcta y recuperarlo tras reiniciar cliente y servidor. Repetir el recorrido completo tres veces sin duplicar personajes ni perder datos. Comprobar aislamiento entre dos cuentas.

Una cuenta, una clase compatible y un mapa son suficientes para el primer recorrido. Una segunda cuenta sirve para probar propiedad y aislamiento. Movimiento básico y visibilidad entre dos jugadores son una extensión posterior, no condiciones ocultas del objetivo inicial.

Fuera de alcance: combate, hechizos, botín, economía, oficios, sublimaciones, todas las clases, launcher propio, panel web, despliegue público y portabilidad a varias versiones. No comenzar estas funciones para distraerse de un bloqueo de conexión.

## Decisión técnica acordada y validaciones pendientes

La unidad que debemos elegir es la combinación emulador + commit + cliente + build + datos + runtime. El nombre del juego o el lenguaje por sí solos no establecen compatibilidad.

Sebastián acepta WakBox-Evolution como candidato principal y el cliente 1.54.0 como objetivo de compatibilidad. Empezaremos por su C++/Qt existente, sin portarlo a Java. La selección no demuestra todavía que compile o permita entrar. Si no hay cliente correspondiente verificable, el candidato no pasa la puerta de viabilidad. Las alternativas solo se reabren ante un bloqueo documentado.

Que el cliente use Java no obliga a escribir el servidor en Java. Para proteger el objetivo de dos meses se conserva el lenguaje del candidato. Una migración futura de lenguaje requiere una decisión explícita y una estimación propia; no forma parte del primer hito.

## Investigación de candidatos

| Candidato | Evidencia leída | Incertidumbre | Uso propuesto |
|---|---|---|---|
| WakBox-Evolution | README declara 1.54.0; rutas de creación/guardado/entrada al mundo en CharacterHandler.cpp. Existen comentarios de actualización pendiente. | Cliente disponible, compilación, datos y funcionamiento real sin comprobar. | Primer candidato para auditoría funcional. |
| WakBox | README declara 1.39.4; hay serialización de entidad y manejo de movimiento. | No se probó; el manejador de movimiento contiene trabajo pendiente. | Alternativa si conseguimos esa versión y arranca mejor. |
| jWakfu | Proyecto inactivo; build Java 8, Netty y Gradle. En el manejador de creación están comentadas las llamadas que añaden/guardan el personaje y se fija CRA. | No se ha identificado de forma fiable su versión comercial de cliente. | Referencia Java y candidato condicionado, no base terminada. |
| WakSharp | C# 4.0, licencia MIT, documento de estructuras para 1.28.2. | El documento no demuestra compatibilidad integral ni entrada al mundo. | Referencia histórica y alternativa C# por verificar. |

En jWakfu hay una constante de build 90414 en Packet7Version; en la función inspeccionada no se usa para validar y se acepta la versión recibida. No convertir ese número en una versión compatible por suposición.

No se ha confirmado una descarga oficial vigente de los clientes históricos citados. El launcher actual no debe asumirse capaz de entregar esas versiones. Investigar primero disponibilidad y procedencia; no basar el calendario en un cliente inexistente o incompleto.

Los árboles inspeccionados de WakBox, WakBox-Evolution y jWakfu no mostraron un archivo de licencia general por nombre. Hay que resolver permisos/licencia antes de adoptar o redistribuir código; público en GitHub no equivale automáticamente a open source. WakSharp sí incluye MIT. Esto no determina la licencia de los assets o del cliente.

Revisiones consultadas (árbol master obtenido por API; no compiladas):

- WakBox-Evolution: bacde4702ed871c639ea81f2179f1619beb42c0b.
- WakBox: a841d3259c557be085b420e503645f9854c7a9f0.
- jWakfu: 5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef.
- WakSharp: 46144895a6320bae8867b297aa987d7e2924713f.

## Qué significa Linux y cómo se manejan las animaciones

Que un programa funcione en Linux no publica su código fuente. Un juego puede distribuir binarios Java y bibliotecas nativas y seguir siendo propietario. OpenJDK o alguna dependencia abierta no convierten en abierto todo el juego. Un código decompilado tampoco adquiere una licencia libre por estar accesible.

Con el cliente original, el plan es aprovechar su representación gráfica existente. El servidor proporciona los datos compatibles de identidad, apariencia, mapa, posición y acciones; el cliente representa el personaje y reproduce sus recursos. Los campos exactos, estados y sincronización deben verificarse para la versión seleccionada.

Para M5 basta comprobar aparición y animación de reposo coherentes. Si se amplía a movimiento, hay que entender inicio, recorrido, dirección, finalización y confirmaciones que use ese cliente. No enviar sprites en cada paquete ni crear animaciones nuevas para sustituir mensajes desconocidos. No se necesita Unity para este objetivo. Un cliente propio y sus recursos serían otro proyecto.

## Cómo elegiremos la base más rentable en horas

Primero, puertas obligatorias: cliente exacto disponible y ejecutable, procedencia identificada y condiciones de uso/reutilización revisadas. Un candidato bloqueado no gana por tener muchas estrellas o archivos.

Después puntuar de 0 a 5 solo con evidencia, dejando desconocidos como ND:

| Criterio | Peso |
|---|---:|
| Recorrido real demostrado hasta personaje/mundo | 35% |
| Compilación reproducible y dependencias recuperables | 20% |
| Datos del mapa/personaje suficientes y coherentes | 20% |
| Coste estimado de resolver bloqueos identificados | 15% |
| Facilidad de mantenerlo y entenderlo entre ambos | 10% |

Si faltan datos, no calcular una falsa clasificación definitiva. Usar el resultado para elegir un único candidato y escribir una decisión breve con las alternativas descartadas.

## Parámetros que fijaremos en M0–M1

| Parámetro | Valor inicial |
|---|---|
| Emulador y commit | Pendiente de prueba; candidatos anteriores |
| Cliente, build y SHA-256 del archivo/distribución | Pendiente |
| Datos del juego y hash del manifiesto | Pendiente; deben corresponder al cliente |
| Runtime del cliente | El que demuestre compatibilidad con ese cliente |
| Toolchain del servidor | Fijado tras elegir candidato |
| Sistema del cliente | Preferentemente el PC donde ya juega Sebastián |
| Sistema del servidor | Local; nativo o WSL2 según dependencias verificadas |
| Host de escucha | Loopback en el primer laboratorio |
| Puertos | Los determinados por el protocolo/configuración; no inventarlos |
| Base de datos | La que requiera el candidato al reproducirlo |
| Cuenta, clase y mapa de prueba | Identificadores comprobados; sin usar cuentas oficiales |
| Retención de registros | Por sesión, sin contraseñas ni tickets reutilizables |
| Capacidad inicial | Una conexión; dos cuentas para pruebas de aislamiento |

Si cliente y servidor se ejecutan entre Windows y WSL2, registrar y probar el destino alcanzable; no suponer que loopback funciona igual con cualquier configuración. No abrir puertos al exterior para solucionar un error de protocolo.

## Metas y pasos

Los tiempos siguientes son presupuestos de investigación/esfuerzo, no garantías. Un bloqueo de cliente o protocolo obliga a revisar alcance. Las fases M1–M6 dependen de superar M0.

### M0 — Viabilidad y elección (presupuesto inicial: 12–18 horas)

1. Inventariar PC, herramientas y cliente disponible sin modificar la instalación habitual.
2. Registrar versión/build/ruta y averiguar si existe un cliente histórico completo de procedencia verificable.
3. Examinar las fuentes de los candidatos: arranque, dependencias, autenticación, selección, creación y mapa.
4. Distinguir código real, respuestas fijas, partes comentadas y datos de ejemplo.
5. Probar como máximo dos candidatos que cumplan las puertas obligatorias.
6. Registrar resultado reproducible, bloqueo y coste de continuar. Elegir base/lenguaje o declarar NO-GO temporal.

Salida: informe comparativo, ficha del cliente y decisión de arquitectura. Cierre: combinación seleccionada con cliente disponible y un procedimiento de compilación/arranque identificado; el objetivo sigue condicionado a los hitos de conexión.

Regla de tiempo: después de 18 horas sin una combinación viable, detener la implementación de funcionalidades. Entregar los bloqueos y opciones concretas; no seguir generando estructuras vacías.

### M1 — Laboratorio reproducible (4–12 horas)

1. Fijar commit, toolchain, dependencias y configuración local.
2. Revisar instrucciones/build antes de ejecutar código histórico.
3. Preparar cuenta/datos de prueba y scripts para iniciar/detener.
4. Capturar logs de cliente y servidor con identificador de sesión.
5. Repetir desde una copia limpia; preservar una referencia de lo que funciona.

Parámetros: runtime, sistema, host, puertos, base de datos y configuración identificados. Cierre: compila y arranca dos veces desde instrucciones escritas; un fallo deja un log interpretable. El cliente abre sin degradar la instalación habitual.

### M2 — Conexión y protocolo inicial (8–24 horas)

1. Identificar cómo configurar el destino en una copia de laboratorio del cliente.
2. Documentar primer mensaje, framing, dirección y estado de sesión.
3. Implementar o corregir únicamente ese intercambio.
4. Documentar servicios auxiliares y autenticación exigidos por la versión. No confundir una conexión TCP con login exitoso.
5. Probar mensajes completos, fragmentados, concatenados y de longitud inválida.

Parámetros: versión de protocolo, tamaño máximo conforme al formato, timeout de laboratorio documentado y destinos. Cierre: intercambio inicial repetible y transición al siguiente estado visible. Si aparece una dependencia no resuelta del launcher/autenticación, registrar el bloqueo antes de continuar.

### M3 — Sesión local y selección (8–24 horas)

1. Completar autenticación de cuenta de prueba y estados de sesión según la evidencia.
2. Mostrar el servidor de laboratorio y transferir sesión si el protocolo lo requiere.
3. Obtener una lista vacía de personajes válida.
4. Rechazar credenciales inválidas y solicitudes fuera de estado.

Parámetros: cuenta local, identificador de servidor y transición de sesión. Cierre: el cliente real muestra la pantalla de selección; no hay dependencia accidental de la cuenta oficial y los datos no se mezclan entre dos cuentas.

### M4 — Crear y conservar personaje (8–24 horas)

1. Documentar los campos de creación para una clase existente en el cliente.
2. Validar nombre, clase y apariencia; derivar propietario de la sesión autenticada.
3. Asignar identificador único y guardar de forma atómica.
4. Responder en el formato esperado y devolver la lista actualizada.
5. Cerrar y reiniciar servidor/cliente; comprobar que el personaje permanece.

Parámetros: una clase admitida, límites de nombre documentados y política explícita de duplicados. Cierre: creación desde interfaz, nombre/apariencia correctos tras reinicio; repetir una petición no produce duplicados y una cuenta no opera personajes ajenos.

### M5 — Entrar al mapa (12–40 horas)

1. Elegir un mapa presente en los datos y una posición válida.
2. Documentar la secuencia de inicialización y serialización completa del actor.
3. Enviar identidad, características mínimas, apariencia, instancia y posición.
4. Resolver cada bloqueo con logs y comparación de evidencia; no rellenar campos desconocidos al azar.
5. Verificar visualmente que termina la carga y aparece el personaje.

Parámetros: mapa, instancia, coordenadas, orientación y apariencia comprobados. Cierre: permanecer dos minutos en el mundo sin desconexión, con personaje visible y sin errores repetidos de protocolo. Reposo visual coherente; movimiento no exigido todavía.

### M6 — Reproducción y cierre (4–8 horas)

1. Ejecutar tres recorridos completos desde arranque hasta mundo.
2. Reiniciar entre recorridos y comprobar misma identidad/apariencia/mapa.
3. Probar acceso con segunda cuenta y rechazo de acceso al personaje de la primera.
4. Guardar logs, capturas, comandos y revisión Git de la demostración.
5. Escribir limitaciones y dejar un punto estable para continuar.

Cierre: lista de aceptación del objetivo satisfecha. Si Sebastián aún no hizo la prueba visual, marcar VERIFICACIÓN PENDIENTE, no terminado.

## Organización acordada el 26 de septiembre de 2026

Objetivo de calendario: 26 de noviembre de 2026. Es una fecha objetivo con controles de viabilidad, no garantía de conexión. El trabajo se realiza en la máquina de Sebastián. `C:\WakfuServer` es la raíz única y `https://github.com/dagemov/WakfuServer` es el remoto oficial público.

Nombre uniforme de la carpeta de documentación: FilesAgents. No usar variantes como FilesAgenst o FilesAgent.

| Ruta relativa a la raíz | Naturaleza y responsabilidad |
|---|---|
| AGENTS.md | Instrucciones breves de arranque y reglas esenciales. |
| FilesAgents/Reglas.md | Convenciones de código, nombres, alcance y evidencias. |
| FilesAgents/Plan.md | Metas y criterios de aceptación; única versión operativa del plan. |
| FilesAgents/Status.md | Fotografía del avance actual; una tarea activa y siguiente acción. |
| FilesAgents/Manejo.md | Rutina de sesiones, Git, lecturas y resolución de bloqueos. |
| FilesAgents/Cliente.md | Versión, build, hashes, runtime y rutas del cliente de laboratorio. |
| FilesAgents/Decisiones.md | Registro compacto de decisiones relevantes y su razón. |
| FilesAgents/Protocolo.md | Índice y hallazgos de protocolo del alcance vigente. |
| README.md | Cómo preparar, ejecutar y comprobar el proyecto. |
| backend/ | Código del candidato, conservando su estructura interna y trazabilidad. |
| databases/ | Esquemas y migraciones versionables; bases y respaldos locales excluidos de Git. |
| cliente/ | Laboratorio del cliente dentro de la raíz; binarios, assets, logs y cachés excluidos de Git. |
| pruebas/ | Se crea solo si existen pruebas transversales que no pertenezcan al módulo del backend. |
| herramientas/ | Se crea con el primer script repetible, no como carpeta vacía. |

No crear carpetas de código vacías por apariencia. Antes de incorporar el candidato, definir importación y procedencia sin anidar accidentalmente otro repositorio Git. Conservar el commit de origen y resolver su licencia. Mantener una sola raíz Git del proyecto.

Este archivo es la única versión operativa del plan. Las reglas viven en `Reglas.md` y `Manejo.md`; `Status.md` contiene la fotografía del trabajo actual. No se mantiene otra copia de `Plan_Wakfu_Codex.md`.

## Lectura de instrucciones y consumo de contexto

Codex descubre `AGENTS.md` al iniciar su ejecución o sesión según la superficie. El archivo corto de la raíz dirige a los documentos aplicables en todo el proyecto.

Los archivos no se memorizan fuera del contexto por existir en disco. Leerlos aporta contexto y tiene coste; no podemos prometer un ahorro exacto ni que las instrucciones nunca se pierdan. La cuota de Plus depende también del modelo, razonamiento, herramientas, tamaño de tarea y contexto. Trabajar localmente permite usar la máquina, pero la inferencia del modelo sigue consumiendo el uso del servicio.

Política vigente:
- Al iniciar una sesión: AGENTS.md, Status.md, Reglas.md y Manejo.md; del plan solo el hito vigente.
- Al retomar tras cambio de rama, modificaciones externas o pérdida/compactación de contexto: comprobar Git y releer el estado e instrucciones pertinentes.
- Dentro de una tarea: consultar solo código, protocolo y documentos relevantes; no releer toda la carpeta tras cada comando.
- Si cambian reglas durante una sesión: leer explícitamente el cambio; para comprobar carga automática, iniciar una nueva sesión cuando proceda.
- Al cerrar una tarea: actualizar únicamente los documentos cuyo estado cambió y comprobar su diff.

Presupuestos orientativos de tamaño: AGENTS.md unas 40–60 líneas; Status.md unas 40–80; reglas y manejo concisos. Son guías para mantenerlos legibles, no límites que justifiquen omitir evidencia. El plan completo no necesita cargarse en cada turno.

La fuente actual manda. Un archivo local recién modificado puede estar por delante de HEAD; por eso git diff importa además del último commit. Una nueva sesión empieza desde el estado guardado, sin pegar la conversación completa. Ningún esquema documental garantiza eliminar todos los loops.

## Los tres puntos verificables de cada sesión

Tomamos estos tres puntos como formato fijo:

1. META: qué resultado observable queremos y cuál es el criterio de cierre.
2. CAMBIO: qué se modificó, por qué, archivos afectados y referencia Git real.
3. PRUEBA: comando o recorrido ejecutado, resultado, evidencia y siguiente paso.

Al empezar, CAMBIO describe lo previsto y PRUEBA cómo se verificará. Al terminar, ambos describen lo que realmente ocurrió. Si no hay prueba con el cliente real, decirlo; no convertir un test simulado en una demostración de integración.

Ejemplo de cierre, no un resultado ya obtenido:
- Meta: que un personaje recién creado siga en la lista tras reiniciar.
- Cambio: el servidor guarda el personaje con el propietario de la sesión; commit real obtenido de Git.
- Prueba: creación desde cliente, reinicio y nueva selección. Si no se ejecutó, verificación pendiente. Próximo paso: inicialización del mapa.

Una sola tarea activa. Cada sesión suele contener un bloque de 60–120 minutos enfocado en esa tarea; puede prolongarse si hay avance claro. Después de dos intentos sin nueva evidencia, detener el ciclo de cambios: resumir hipótesis, resultados y dato que falta. Continuar con una prueba que discrimine entre hipótesis, no repetir la misma solución.

## Actualización en el mismo lugar y control de versiones

Git conservará el historial. No generar Plan_v2.md, Status_final.md, carpetas por fecha, copias de respaldo del proyecto ni entregables nuevos para cada sesión. No mantener un diario creciente que haya que cargar completo. Status.md sustituye su resumen por el estado actual; Decisiones.md conserva solo decisiones útiles. Logs locales rotables son evidencia de ejecución, no versiones alternativas de documentos.

Cada tarea lógica se cierra así:
1. Revisar cambios y ejecutar pruebas relevantes.
2. Actualizar Status.md y documentación afectada con el resultado real.
3. Revisar el diff de código y documentos.
4. Crear un commit coherente con mensaje humano.
5. Obtener hash, fecha y asunto desde Git; mostrarlos en el cierre.
6. Publicar la rama al remoto configurado según el flujo acordado.

No guardar dentro de un archivo el hash del mismo commit que va a contenerlo: modificar el archivo para añadirlo produciría otro commit. Si Status.md cita una revisión, debe ser un commit previo e identificado como referencia comprobada. El estado y su resumen se guardan con el cambio; la identidad del commit que los contiene se obtiene de Git.

Comandos de inspección del flujo, para ejecutar posteriormente dentro del repositorio:
- git status --short
- git diff --stat
- git log -1 --date=iso-strict --format="%h | %ad | %s"
- git log -1 --date=iso-strict --format="%h | %ad | %s" -- FilesAgents/Status.md

Git contiene las fechas y el mensaje. Status.md añade fecha/hora de actualización con zona America/New_York cuando cambie el estado de trabajo. No crear un commit solo para renovar una fecha sin cambio sustantivo.

Repositorio oficial: `dagemov/WakfuServer`, público. Usar `main` como referencia estable y ramas cortas con nombres como `preparar-proyecto` o `guardar-personaje`. Revisar mediante PR al cerrar una tarea coherente o hito, no por cada archivo. No habilitar revisión IA automática de cada push por defecto.

No subir cliente, assets sin permiso de redistribución, credenciales, configuraciones secretas, volcados de base de datos, logs crudos ni binarios generados. Versionar esquemas, migraciones, configuración de ejemplo y pruebas con datos adecuados. Mantener la atribución y commit de origen del candidato.

## Nombres humanos y comprensibles

Documentos y explicaciones en español. Código nuevo sigue el idioma y convenciones del módulo existente: no renombrar masivamente el emulador. Un nombre debe describir una responsabilidad real.

Preferir CharacterRepository, CreateCharacterHandler o CharacterAppearance cuando esas responsabilidades existan. Evitar Manager2, NewSystem, FinalFix, UltraEngine y abreviaturas inventadas. No añadir capas, interfaces o patrones solo para sonar profesional.

Mensajes de commit sugeridos:
- "Prepara el entorno de compilación del servidor"
- "Guarda el personaje al terminar su creación"
- "Corrige la apariencia al seleccionar el personaje"
- "Documenta el bloqueo al cargar el mapa"

Comentarios de código explican la razón, restricción o evidencia; no repiten línea por línea lo que hace el código.

## Calendario objetivo de dos meses

| Fechas de 2026 | Meta esperada | Evidencia |
|---|---|---|
| 26 septiembre–9 octubre | M0 y preparación M1 | Cliente verificable, entorno y candidato viable. |
| 10–23 octubre | M1–M2 | Arranque reproducible e intercambio inicial real. |
| 24 octubre–6 noviembre | M3–M4 | Selección y personaje persistente. |
| 7–20 noviembre | M5 | Entrada visible al mapa. |
| 21–26 noviembre | M6 y margen | Tres recorridos y revisión final. |

Planificar 10–15 horas semanales si es posible: unas 80–120 horas en ocho semanas. Si se mantienen nueve horas, la disponibilidad será menor y lo reflejaremos en cada revisión. Las estimaciones técnicas anteriores son intervalos de incertidumbre; no demuestran que todo quepa en la fecha.

Control del 9 de octubre: si no hay cliente compatible ejecutable o entorno viable, declarar en riesgo el objetivo y resolver ese bloqueo antes de programar más funciones. Control del 23 de octubre: si aún no hay intercambio real, reestimar la fecha y el esfuerzo con lo aprendido. No falsificar un cierre para conservar el calendario.

Prioridad: crear personaje, entrar al mundo y persistir. Combate, clases adicionales, panel administrativo y reescritura en otro lenguaje siguen fuera de alcance.

## Inicio operativo

La primera tarea es preparar la raíz y su documentación. Después se inventariarán cliente y herramientas disponibles sin modificar la instalación habitual.

Orden:

1. Vincular `C:\WakfuServer` con el remoto oficial y comprobar escritura.
2. Preparar los documentos en las rutas acordadas, sin variantes.
3. Registrar la jerarquía de `backend/`, `databases/` y `cliente/`.
4. Guardar el primer estado comprobado y publicar la rama de preparación.
5. Identificar instalación, versión, build, runtime y herramientas disponibles.
6. Continuar con la viabilidad del cliente 1.54.0.

No instalar toolchains al azar ni anunciar conexión antes de demostrarla. El próximo dato técnico necesario es el inventario local; no hace falta repetir la investigación de candidatos si no hay novedades.

## Fuentes consultadas

- [WakBox-Evolution](https://github.com/WakBox/WakBox-Evolution) — README y árbol.
- [CharacterHandler.cpp en la revisión inspeccionada](https://github.com/WakBox/WakBox-Evolution/blob/bacde4702ed871c639ea81f2179f1619beb42c0b/worldserver/Game/Handlers/CharacterHandler.cpp) — creación y entrada; lectura directa del código.
- [WakBox](https://github.com/WakBox/WakBox) — README y manejadores.
- [jWakfu](https://github.com/aristotaloss/jWakfu) — estado declarado.
- [Build de jWakfu](https://github.com/aristotaloss/jWakfu/blob/5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef/build.gradle) — Java y dependencias.
- [Creación en jWakfu](https://github.com/aristotaloss/jWakfu/blob/5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef/src/main/java/com/velocity/jwakfu/net/packets/in/Packet2053CreateCharacter.java) — lectura directa, persistencia comentada.
- [Versión en jWakfu](https://github.com/aristotaloss/jWakfu/blob/5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef/src/main/java/com/velocity/jwakfu/net/packets/in/Packet7Version.java) — build y aceptación de versión.
- [WakSharp](https://github.com/nightwolf93/WakSharp) — README, árbol y LICENSE.
- [Ankama: funcionamiento de Wakfu](https://support.ankama.com/hc/es/articles/17045319145361--WAKFU-Problemas-con-el-funcionamiento-del-juego-WAKFU) — Linux y logs Java.
- [Ankama: rendimiento](https://support.ankama.com/hc/es/articles/44665357907473--WAKFU-Problema-de-rendimiento) — runtime Java del cliente.
- [Open Source Definition](https://opensource.org/osd) — fuente y licencia.
- [Codex: AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md) — instrucciones persistentes de proyecto.

La selección, tiempos, hitos y reglas de trabajo son propuestas de planificación propias. La inspección de archivos públicos no sustituye una prueba de compilación ni una sesión con el cliente.
- [Codex: uso y límites](https://learn.chatgpt.com/docs/pricing) — factores de consumo y reducción de contexto.
