# Estado actual

Actualizado: 2026-10-07T20:06:01-04:00 (`America/New_York`)

## Hito

M0 — Viabilidad y elección. `NO-GO temporal`.

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

## Tarea activa

Conseguir los insumos externos que permitan reabrir M0: un cliente histórico verificable y permiso de reutilización para una base funcional.

## META

Obtener la identidad completa y una distribución verificable del cliente 1.54.0 y aclarar la licencia de WakBox-Evolution, o acordar un nuevo alcance técnico estimado.

Criterio de cierre: existe en `cliente/instalacion/` una copia autorizada con procedencia, build, runtime y hashes comprobados, y la base elegida tiene permiso de reutilización comprobable.

## CAMBIO previsto

- contrastar un posible paquete o manifiesto aportado con fecha, versión y procedencia;
- solicitar o comprobar permiso de reutilización del candidato antes de importarlo;
- descargar únicamente una distribución que supere la comprobación;
- registrar build, runtime, arquitectura, tamaño y SHA-256 dentro de la ficha vigente;
- mantener el cliente y sus assets fuera de Git.

## PRUEBA prevista

- el origen es oficial o conserva evidencia verificable de la distribución oficial;
- el paquete completo abre desde la copia de laboratorio sin actualizar la instalación habitual;
- la versión informada por el cliente es 1.54.0;
- los hashes se pueden recalcular;
- `git status` no incluye binarios ni assets propietarios.

## Bloqueos y límites

- Falta el identificador completo de build, manifiesto o paquete del cliente 1.54.0.
- El índice actual del CDN no ofrece historial y las capturas consultadas no conservan la distribución de junio de 2017.
- El historial público de Steam oculta las entradas antiguas sin autenticación y no se encontró una copia local histórica.
- No se instalará un toolchain hasta superar o replantear la puerta del cliente.
- WakBox-Evolution no tiene una licencia general visible en el commit inspeccionado; publicarlo requiere permiso o una base diferente.
- WakSharp tampoco es viable para el objetivo: no hay cliente 1.28.2 verificable y su recorrido se detiene antes de entrar al mundo.
- Git conserva permiso de escritura mediante las credenciales de Windows; el token independiente de GitHub CLI está vencido.
- La instancia MariaDB de M0 usa `root` sin contraseña y escucha solo en loopback. Se reemplazará por un usuario propio con credencial local cuando exista un backend autorizado para integrar.

## Siguiente acción exacta

Revisar la respuesta de [WakBox-Evolution #3](https://github.com/WakBox/WakBox-Evolution/issues/3) y verificar cualquier build, manifiesto, paquete o permiso que aporte el mantenedor. Si aparece una distribución válida, guardarla solo en `cliente/instalacion/` y registrar su procedencia, versión, runtime y SHA-256 antes de abrir M1.
