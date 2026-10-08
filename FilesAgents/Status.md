# Estado actual

Actualizado: 2026-10-07T20:30:52-04:00 (`America/New_York`)

## Hito

M0 — Especificación, cliente y elección. `ACTIVO` con alcance replanteado.

## Último resultado comprobado

- Se inventariaron sin modificar las instalaciones `main` y `beta` administradas por Ankama Launcher; ambas son actuales y no corresponden a 1.54.0.
- `FilesAgents/Cliente.md` registra rutas, builds anunciados, Java 21, tamaños y SHA-256 repetibles de los clientes observados.
- El equipo no tiene Qt/qmake ni un toolchain C++ utilizable para reproducir WakBox-Evolution.
- El commit candidato inspeccionado es `bacde4702ed871c639ea81f2179f1619beb42c0b`: C++/qmake, Qt Core/Network/Sql, MySQL, Protocol Buffers 3.2.0, Crypto++ 5.6.3 y QuaZip.
- El árbol candidato no contiene una licencia general comprobable; no se puede copiar todavía al repositorio público.
- Se definieron la arquitectura por capas, la aplicación incremental de SOLID y el perfil técnico de reproducción.
- La ruta oficial de descarga usada en 2017 quedó identificada, pero no apareció un paquete ni manifiesto verificable del cliente 1.54.0.
- El historial público de Steam no expuso un manifiesto de 2017 y la búsqueda local dirigida no encontró una copia histórica.
- Se evaluó el segundo candidato permitido por M0: WakSharp tiene licencia MIT y persistencia parcial, pero requiere el cliente 1.28.2, dependencias históricas incompletas y carece de selección/entrada al mapa.
- Ninguna de las dos combinaciones supera las puertas obligatorias; no se importó código ni se programaron funciones de hitos posteriores.
- Se preparó MariaDB 10.4.32 en `databases/local/`, se aplicaron las bases `wakbox_auth`, `wakbox_char` y `wakbox_world`, y Navicat validó el perfil local con una conexión real.
- Se abrió la consulta pública [WakBox-Evolution #3](https://github.com/WakBox/WakBox-Evolution/issues/3) para solicitar la identidad verificable del cliente 1.54.0 y la licencia de reutilización del código.
- Se replanteó el objetivo: el producto será `Wakfu-RevolutionEmu`, una implementación propia; WakBox-Evolution pasa a ser referencia auditada y no código base automático.
- El plan conserva tres rutas finales: modernizar WakBox con licencia y cliente, crear RevolutionEmu para 1.54.0, o usar un build actual congelado. La segunda es la preferida y la tercera es el fallback si termina la búsqueda histórica.
- La publicación oficial conservada por Steam confirma la salida de 1.54 el 26 de junio de 2017, pero la nueva búsqueda tampoco encontró un paquete o manifiesto verificable.
- Se descargó e inspeccionó sin ejecutar el archivo que Uptodown etiqueta `1.3.0.0`: su firma de Ankama y su SHA-256 son válidos, pero es un instalador/actualizador NSIS de 2014 de 5.373.208 bytes, no el cliente completo.
- El instalador solo contiene el launcher `transition`, configuraciones y bibliotecas Qt 4; espera descargar `core.jar`, librerías y datos desde `dl.ak.ankama.com`, nombre que ya no resolvió. Este candidato no habilita M1 ni identifica una versión del protocolo.

## Tarea activa

Construir una especificación durable mediante la auditoría profunda de WakBox-Evolution y cerrar la disponibilidad real del cliente 1.54.0.

## META

Documentar lo necesario para implementar `Wakfu-RevolutionEmu` sin releer todo el candidato en cada sesión y decidir entre las opciones A, B o C con evidencia.

Criterio de cierre: `EstudioWakBox.md` identifica módulos, arranque, dependencias, estados de sesión, persistencia, mensajes, vacíos y fuentes exactas; `Cliente.md` cierra la disponibilidad de 1.54.0; una prueba mínima permite fijar lenguaje y frameworks.

## CAMBIO previsto

- obtener en `local/referencias/` una copia sin `.git` fijada al commit auditado;
- crear `EstudioWakBox.md` con el primer bloque real de resultados;
- recorrer historial, build, arquitectura, conexión, sesión, persistencia y entrada al mundo en ese orden;
- continuar la búsqueda limitada del cliente 1.54.0 y registrar únicamente evidencia nueva;
- diseñar después una prueba pequeña de stack sin comenzar funciones de M1.

## PRUEBA prevista

- cada hallazgo cita commit, ruta y símbolo, y distingue evidencia estática, ejecución, hipótesis y pendiente;
- la copia de referencia, cliente, assets, registros y binarios permanecen fuera de Git;
- el mapa documentado permite localizar un flujo sin volver a recorrer todo el árbol;
- la búsqueda del cliente termina al consumir 20 horas adicionales sin evidencia nueva;
- la opción elegida satisface sus puertas de cliente, publicación y coste.

## Bloqueos y límites

- Falta el identificador completo de build, manifiesto o paquete del cliente 1.54.0.
- El ejecutable `1.3.0.0` de Uptodown no sustituye ese dato: la numeración pertenece al instalador y falta la distribución Java que debía descargar.
- El índice actual del CDN no ofrece historial y las capturas consultadas no conservan la distribución de junio de 2017.
- El historial público de Steam oculta las entradas antiguas sin autenticación y no se encontró una copia local histórica.
- WakBox-Evolution no tiene una licencia general visible en el commit inspeccionado; publicarlo requiere permiso o una base diferente.
- WakSharp tampoco es viable para el objetivo: no hay cliente 1.28.2 verificable y su recorrido se detiene antes de entrar al mundo.
- Git conserva permiso de escritura mediante las credenciales de Windows; el token independiente de GitHub CLI está vencido.
- La instancia MariaDB de M0 usa `root` sin contraseña y escucha solo en loopback. Se reemplazará por un usuario propio con credencial local cuando exista un backend autorizado para integrar.

## Siguiente acción exacta

Obtener el archivo fuente de la revisión auditada de WakBox-Evolution en `local/referencias/` sin incluir `.git`, comprobar su hash y crear `EstudioWakBox.md` con historial de versiones, proceso de build y puntos de arranque. En paralelo, revisar únicamente novedades de [WakBox-Evolution #3](https://github.com/WakBox/WakBox-Evolution/issues/3).
