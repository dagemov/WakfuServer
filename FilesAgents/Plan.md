# Plan operativo: crear Wakfu-RevolutionEmu

Fecha de investigación inicial: 26 de septiembre de 2026. Estrategia revisada: 7 de octubre de 2026.
Estado: M0 replanteado para diseñar un emulador propio. Existe inspección estática parcial de fuentes públicas, pero ningún emulador se ha compilado o conectado a un cliente real.

## Objetivo y alcance

Crear un emulador propio llamado `Wakfu-RevolutionEmu`, comprensible y publicable, construido a partir de especificaciones y pruebas reproducibles. WakBox-Evolution será una referencia histórica de investigación; no será automáticamente el código base del producto.

El primer objetivo funcional sigue siendo que, desde una instalación reproducible, una cuenta local de prueba pueda crear un personaje desde la interfaz del cliente elegido, seleccionarlo, entrar en un mapa con apariencia correcta y recuperarlo tras reiniciar cliente y servidor. El recorrido se repetirá tres veces sin duplicar personajes ni perder datos y se comprobará el aislamiento entre dos cuentas.

Una cuenta, una clase compatible y un mapa son suficientes para el primer recorrido. Una segunda cuenta sirve para probar propiedad y aislamiento. Movimiento básico y visibilidad entre dos jugadores son una extensión posterior, no condiciones ocultas del objetivo inicial.

Fuera de alcance inicial: combate, hechizos, botín, economía, oficios, sublimaciones, todas las clases, launcher propio, panel web, despliegue público y compatibilidad simultánea con varias versiones. No comenzar estas funciones para distraerse de un bloqueo de conexión.

## Decisión técnica acordada y validaciones pendientes

La unidad que debemos fijar es la combinación especificación + cliente + build + datos + runtime + implementación. El nombre del juego o el lenguaje por sí solos no establecen compatibilidad.

La estrategia preferida es una implementación propia de `Wakfu-RevolutionEmu` contra el cliente 1.54.0, si aparece una distribución verificable. Antes de programar el protocolo se realizará una auditoría profunda de WakBox-Evolution para extraer arquitectura, flujos, contratos, dependencias, vacíos y preguntas comprobables. Los hallazgos se documentarán como conocimiento del proyecto con referencia a commit, archivo y símbolo; no se copiarán fragmentos ni se traducirá mecánicamente su código.

La auditoría no obliga a conservar C++/Qt. El lenguaje y los frameworks de `Wakfu-RevolutionEmu` se decidirán al cerrar M0 mediante una prueba pequeña de framing, serialización y acceso a MariaDB. Se valorarán comprensión para Sebastián, pruebas, disponibilidad de bibliotecas, coste de mantenimiento y compatibilidad con el protocolo. El lenguaje Java del cliente tampoco obliga a usar Java en el servidor.

Si se obtiene una licencia expresa de WakBox-Evolution, la ruta de modernizarlo seguirá disponible como alternativa de menor coste. Si no aparece el cliente 1.54.0 después de la búsqueda limitada de M0, el objetivo se trasladará a una copia fija y verificable del cliente actual, con una reestimación completa antes de programar.

## Referencias ya evaluadas

| Referencia | Evidencia leída | Incertidumbre | Uso propuesto |
|---|---|---|---|
| WakBox-Evolution | README declara 1.54.0; rutas de creación/guardado/entrada al mundo en CharacterHandler.cpp. Existen comentarios de actualización pendiente. | Cliente disponible, compilación, datos y funcionamiento real sin comprobar. | Referencia principal para auditoría funcional. |
| WakBox | README declara 1.39.4; hay serialización de entidad y manejo de movimiento. | No se probó; el manejador de movimiento contiene trabajo pendiente. | Referencia histórica puntual, no candidato de implementación. |
| jWakfu | Proyecto inactivo; build Java 8, Netty y Gradle. En el manejador de creación están comentadas las llamadas que añaden/guardan el personaje y se fija CRA. | No se ha identificado de forma fiable su versión comercial de cliente. | Referencia Java puntual, no base del producto. |
| WakSharp | C# 4.0, licencia MIT, documento de estructuras para 1.28.2. | El documento no demuestra compatibilidad integral ni entrada al mundo. | Referencia histórica con licencia clara, no candidato de implementación. |

## Tres opciones finales viables

Las horas son estimaciones de planificación basadas en la evidencia actual, no promesas. Suponen trabajo local, un solo recorrido vertical y 10–15 horas semanales. El coste monetario directo puede mantenerse bajo; el coste principal es tiempo de investigación y programación.

| Opción | Condición de entrada | Esfuerzo inicial estimado | Tiempo orientativo | Viabilidad y decisión |
|---|---|---:|---:|---|
| A. Modernizar WakBox-Evolution | Licencia expresa, cliente 1.54.0 verificable y compilación de referencia | 80–180 horas | 2–4 meses | Es la ruta más rápida, pero hoy está bloqueada por licencia y cliente. Se activa solo si supera las tres puertas. |
| B. Crear Wakfu-RevolutionEmu para 1.54.0 | Cliente 1.54.0 verificable y especificación suficiente | 220–450 horas | 5–10 meses | **Ruta recomendada.** Ofrece control, nombres comprensibles y publicación propia. La auditoría de WakBox reduce incertidumbre sin convertirlo en código base. |
| C. Crear Wakfu-RevolutionEmu para un build actual congelado | Copia actual separada, build y hashes fijos; condiciones de uso revisadas | 400–800 horas | 9–18 meses | Fallback viable si 1.54.0 no aparece. El cliente está disponible, pero autenticación, servicios auxiliares y protocolo moderno aumentan el coste. No se perseguirán actualizaciones continuas. |

Regla de selección:

1. Si WakBox obtiene licencia, aparece el cliente 1.54.0 y compila sin cambios funcionales, comparar A y B con evidencia real.
2. Si aparece el cliente 1.54.0 pero la licencia no permite reutilizar WakBox, ejecutar B.
3. Si no aparece una distribución verificable de 1.54.0 al cerrar la búsqueda limitada, reestimar y ejecutar C únicamente con un build actual congelado.

WakSharp, jWakfu y nuevas búsquedas amplias dejan de ser candidatos de implementación. Pueden aportar referencias puntuales con licencia y procedencia comprobadas, pero no reabren una competencia indefinida entre emuladores.

## Auditoría profunda de WakBox-Evolution

La auditoría trabaja sobre una revisión fijada y una copia local sin repositorio anidado bajo `local/referencias/`, excluida de Git. No se incorpora código a `backend/` mientras no exista permiso de reutilización.

El estudio recorre en este orden:

1. historial de commits relacionado con versiones del cliente;
2. proceso de compilación, dependencias y puntos de arranque;
3. separación entre autenticación, mundo, red, persistencia y datos;
4. máquina de estados de sesión desde conexión hasta entrada al mapa;
5. framing, serialización, cifrado, compresión y mensajes Protocol Buffers;
6. esquema SQL, repositorios y ciclo de vida de cuenta y personaje;
7. servicios auxiliares, configuraciones del cliente y destinos de red;
8. respuestas fijas, funciones incompletas, código comentado y supuestos ocultos;
9. pruebas faltantes, riesgos de seguridad y dependencias sin licencia clara.

El conocimiento duradero se divide así:

- `FilesAgents/EstudioWakBox.md`: mapa de módulos, flujos, dependencias, vacíos y referencias exactas de origen;
- `FilesAgents/Protocolo.md`: estados, mensajes y contratos comprobados;
- `FilesAgents/Cliente.md`: build, runtime, procedencia, configuración y hashes del cliente;
- `FilesAgents/Decisiones.md`: elecciones que cambian arquitectura o alcance.

Cada hallazgo incluirá fuente, comportamiento observado, confianza, consecuencia para la implementación propia y prueba pendiente. La meta es no tener que releer todo WakBox en cada sesión; se vuelve al código original únicamente cuando un hallazgo necesita ampliación o verificación.

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

## Cómo elegiremos la ruta más rentable en horas

Primero, puertas obligatorias: cliente exacto disponible y ejecutable, procedencia identificada y condiciones de publicación claras. Una ruta bloqueada no gana por tener más código histórico.

Después puntuar de 0 a 5 solo con evidencia, dejando desconocidos como ND:

| Criterio | Peso |
|---|---:|
| Recorrido real demostrable hasta personaje/mundo | 30% |
| Cliente y datos verificables | 25% |
| Permiso de publicación y control del código | 20% |
| Coste estimado de resolver bloqueos identificados | 15% |
| Facilidad de mantenerlo y entenderlo entre ambos | 10% |

Si faltan datos, no calcular una falsa clasificación definitiva. Usar el resultado para elegir una sola opción A, B o C y registrar por qué las otras quedan en reserva.

## Parámetros que fijaremos en M0–M1

| Parámetro | Valor inicial |
|---|---|
| Producto | `Wakfu-RevolutionEmu` |
| Referencia auditada | WakBox-Evolution en revisión fijada; no incorporada al producto |
| Cliente, build y SHA-256 del archivo/distribución | Pendiente |
| Datos del juego y hash del manifiesto | Pendiente; deben corresponder al cliente |
| Runtime del cliente | El que demuestre compatibilidad con ese cliente |
| Toolchain del servidor | Fijado tras la prueba técnica de M0 |
| Sistema del cliente | Preferentemente el PC donde ya juega Sebastián |
| Sistema del servidor | Local; nativo o WSL2 según dependencias verificadas |
| Host de escucha | Loopback en el primer laboratorio |
| Puertos | Los determinados por el protocolo/configuración; no inventarlos |
| Base de datos | MariaDB local ya preparada; esquema de producción pendiente del dominio real |
| Cuenta, clase y mapa de prueba | Identificadores comprobados; sin usar cuentas oficiales |
| Retención de registros | Por sesión, sin contraseñas ni tickets reutilizables |
| Capacidad inicial | Una conexión; dos cuentas para pruebas de aislamiento |

Si cliente y servidor se ejecutan entre Windows y WSL2, registrar y probar el destino alcanzable; no suponer que loopback funciona igual con cualquier configuración. No abrir puertos al exterior para solucionar un error de protocolo.

## Metas y pasos

Los tiempos siguientes son presupuestos de investigación/esfuerzo, no garantías. Un bloqueo de cliente o protocolo obliga a revisar alcance. Las fases M1–M6 dependen de superar M0.

### M0 — Especificación, cliente y elección (presupuesto nuevo: 30–55 horas)

1. Fijar la revisión de WakBox-Evolution y completar su auditoría profunda sin incorporarlo a `backend/`.
2. Documentar arquitectura, estados de sesión, dependencias, persistencia, mensajes conocidos, vacíos y evidencia de cada hallazgo.
3. Ejecutar una última búsqueda limitada del cliente 1.54.0: historial de WakBox, mantenedor, manifiesto oficial o de Steam identificado y copias propias verificables.
4. Si aparece el cliente, guardar la copia solo en `cliente/instalacion/`, comprobar apertura aislada y registrar build, runtime y hashes.
5. Construir una prueba técnica mínima para elegir lenguaje y frameworks del emulador propio: framing binario, mensaje serializado, prueba automatizada y acceso a MariaDB.
6. Aplicar la regla de selección entre A, B y C y registrar una única ruta activa.

Salida: `EstudioWakBox.md`, ficha vigente del cliente, especificación inicial de protocolo, prueba técnica del stack y decisión final de ruta. Cierre: el siguiente hito conoce cliente/build objetivo, lenguaje, frameworks, primer intercambio y límites de publicación.

Regla de tiempo: dedicar como máximo 20 horas adicionales a encontrar 1.54.0 y como máximo 35 horas a la auditoría y prueba de stack. Sin evidencia nueva se cierra la búsqueda histórica y se reestima la opción C; no se repiten búsquedas ni se programan funciones para ocultar el bloqueo.

### M1 — Esqueleto reproducible de Wakfu-RevolutionEmu (30–70 horas)

1. Fijar runtime, toolchain, dependencias y configuración del emulador propio.
2. Crear solo los módulos exigidos por autenticación, mundo, protocolo, persistencia y composición.
3. Preparar cuenta/datos de prueba y reutilizar los scripts de MariaDB ya comprobados.
4. Implementar configuración local sin secretos y registros por sesión.
5. Repetir compilación, pruebas y arranque desde una copia limpia.

Parámetros: runtime, sistema, host, puertos, base de datos y configuración identificados. Cierre: el emulador propio compila y arranca dos veces desde instrucciones escritas; un fallo deja un registro interpretable y las dependencias apuntan hacia las reglas de dominio acordadas.

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
| FilesAgents/EstudioWakBox.md | Conocimiento depurado de la referencia: módulos, flujos, dependencias, vacíos y fuentes exactas. Se crea con el primer bloque real de auditoría. |
| README.md | Cómo preparar, ejecutar y comprobar el proyecto. |
| backend/ | Código propio de Wakfu-RevolutionEmu. Una fuente externa solo entra con licencia y procedencia resueltas. |
| databases/ | Esquemas y migraciones versionables; bases y respaldos locales excluidos de Git. |
| cliente/ | Laboratorio del cliente dentro de la raíz; binarios, assets, logs y cachés excluidos de Git. |
| pruebas/ | Se crea solo si existen pruebas transversales que no pertenezcan al módulo del backend. |
| herramientas/ | Se crea con el primer script repetible, no como carpeta vacía. |

No crear carpetas de código vacías por apariencia. Una referencia externa se conserva bajo `local/referencias/`, sin `.git` anidado, fijada por commit y excluida del repositorio. Solo puede entrar en `backend/` con licencia, método de incorporación y procedencia resueltos. Mantener una sola raíz Git del proyecto.

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

No subir cliente, assets sin permiso de redistribución, credenciales, configuraciones secretas, volcados de base de datos, logs crudos ni binarios generados. Versionar esquemas, migraciones, configuración de ejemplo y pruebas con datos adecuados. Mantener atribución, commit y ruta exacta de cualquier referencia externa.

## Nombres humanos y comprensibles

Documentos y explicaciones en español. Código nuevo sigue el idioma y convenciones del módulo existente: no renombrar masivamente el emulador. Un nombre debe describir una responsabilidad real.

Preferir CharacterRepository, CreateCharacterHandler o CharacterAppearance cuando esas responsabilidades existan. Evitar Manager2, NewSystem, FinalFix, UltraEngine y abreviaturas inventadas. No añadir capas, interfaces o patrones solo para sonar profesional.

Mensajes de commit sugeridos:
- "Prepara el entorno de compilación del servidor"
- "Guarda el personaje al terminar su creación"
- "Corrige la apariencia al seleccionar el personaje"
- "Documenta el bloqueo al cargar el mapa"

Comentarios de código explican la razón, restricción o evidencia; no repiten línea por línea lo que hace el código.

## Calendario por puertas de evidencia

El objetivo anterior de dos meses deja de ser válido al elegir un emulador propio. Se trabaja por presupuestos de horas y puertas observables:

| Etapa | Presupuesto | Evidencia para continuar |
|---|---:|---|
| M0: auditoría, cliente y stack | 30–55 horas | Estudio depurado, build objetivo y prueba técnica del stack. |
| M1–M2: esqueleto e intercambio inicial | 60–140 horas | Arranque reproducible y primer intercambio con cliente real. |
| M3–M4: sesión y personaje persistente | 80–160 horas | Selección, creación y recuperación tras reinicio. |
| M5–M6: mapa y reproducción | 80–180 horas | Entrada visible y tres recorridos completos. |

Con 10–15 horas semanales, la opción B requiere aproximadamente 5–10 meses si 1.54.0 aparece. La opción C requiere una reestimación propia y puede superar un año. Cada puerta reemplaza la fecha prevista cuando la evidencia contradice la estimación. No se falsifica un cierre para conservar un calendario.

Prioridad: crear personaje, entrar al mundo y persistir. Combate, clases adicionales, panel administrativo y reescritura en otro lenguaje siguen fuera de alcance.

## Inicio operativo de la nueva estrategia

Orden:

1. Crear la ficha `EstudioWakBox.md` con el primer bloque real de auditoría.
2. Obtener una copia de fuente sin `.git` en `local/referencias/`, fijada por hash y excluida del repositorio público.
3. Auditar historial, build, módulos y recorrido conexión–mundo en el orden definido por M0.
4. Continuar en paralelo la búsqueda limitada del cliente 1.54.0 y la consulta al mantenedor.
5. Diseñar la prueba mínima de stack con los contratos ya extraídos.
6. Cerrar M0 eligiendo A, B o C y solo entonces crear código de producción en `backend/`.

No instalar toolchains al azar, copiar fuentes externas a `backend/` ni anunciar compatibilidad antes de demostrarla con el cliente real.

## Fuentes consultadas

- [WakBox-Evolution](https://github.com/WakBox/WakBox-Evolution) — README y árbol.
- [Steam: publicación de la actualización 1.54](https://store.steampowered.com/news/posts/?appids=215080&enddate=1508910940) — confirma la salida pública del 26 de junio de 2017, pero no ofrece el paquete histórico.
- [CharacterHandler.cpp en la revisión inspeccionada](https://github.com/WakBox/WakBox-Evolution/blob/bacde4702ed871c639ea81f2179f1619beb42c0b/worldserver/Game/Handlers/CharacterHandler.cpp) — creación y entrada; lectura directa del código.
- [WakBox](https://github.com/WakBox/WakBox) — README y manejadores.
- [jWakfu](https://github.com/aristotaloss/jWakfu) — estado declarado.
- [Build de jWakfu](https://github.com/aristotaloss/jWakfu/blob/5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef/build.gradle) — Java y dependencias.
- [Creación en jWakfu](https://github.com/aristotaloss/jWakfu/blob/5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef/src/main/java/com/velocity/jwakfu/net/packets/in/Packet2053CreateCharacter.java) — lectura directa, persistencia comentada.
- [Versión en jWakfu](https://github.com/aristotaloss/jWakfu/blob/5e6a993f0f3df7c1e25112bef1f35ef64f35c7ef/src/main/java/com/velocity/jwakfu/net/packets/in/Packet7Version.java) — build y aceptación de versión.
- [WakSharp](https://github.com/nightwolf93/WakSharp) — README, árbol y LICENSE.
- [Consulta sobre cliente 1.54.0 y licencia](https://github.com/WakBox/WakBox-Evolution/issues/3) — solicitud pública pendiente de respuesta.
- [GitHub: licenciar un repositorio](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository) — alcance de un repositorio público sin licencia general.
- [Ankama: funcionamiento de Wakfu](https://support.ankama.com/hc/es/articles/17045319145361--WAKFU-Problemas-con-el-funcionamiento-del-juego-WAKFU) — Linux y logs Java.
- [Ankama: rendimiento](https://support.ankama.com/hc/es/articles/44665357907473--WAKFU-Problema-de-rendimiento) — runtime Java del cliente.
- [Open Source Definition](https://opensource.org/osd) — fuente y licencia.
- [Codex: AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md) — instrucciones persistentes de proyecto.

La selección, tiempos, hitos y reglas de trabajo son propuestas de planificación propias. La inspección de archivos públicos no sustituye una prueba de compilación ni una sesión con el cliente.
- [Codex: uso y límites](https://learn.chatgpt.com/docs/pricing) — factores de consumo y reducción de contexto.
