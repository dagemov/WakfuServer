# Backend

Esta carpeta alojará el código propio de `Wakfu-RevolutionEmu` después de superar las puertas de M0.

Antes de crear código de producción se debe registrar:

- cliente y build objetivo;
- lenguaje, toolchain, frameworks y dependencias elegidos mediante la prueba técnica de M0;
- contratos iniciales de red, serialización y persistencia;
- componentes mínimos que participan en autenticación, selección, creación y mundo.

No se anidará otro directorio `.git`, se copiarán fuentes de referencia ni se crearán capas vacías. Cada carpeta aparecerá con una responsabilidad y un consumidor reales.

## Referencia técnica de investigación

WakBox-Evolution usa la combinación histórica observada siguiente:

- C++ con proyectos qmake;
- Qt 5: Core, Network y Sql;
- MySQL mediante el controlador `QMYSQL`;
- Protocol Buffers 3.2.0;
- Crypto++ 5.6.3;
- QuaZip, con versión exacta todavía pendiente.

Los rastros de compilación del repositorio mencionan Qt 5.0.2 y Qt 5.8.0 con MinGW de 32 bits. Estas versiones describen la referencia y no determinan el stack del emulador propio.

## Capas que guiarán el código propio

La arquitectura se aplicará sobre responsabilidades demostradas por el primer recorrido vertical:

| Capa | Responsabilidad |
|---|---|
| Dominio | Personajes, criaturas, objetos y reglas del mundo sin dependencias externas. |
| Aplicación | Casos de uso para autenticar, crear, seleccionar y entrar al mundo. |
| Entrada y salida | Sesiones, mensajes y traducción del protocolo. |
| Infraestructura | Red, MariaDB, configuración, serialización, criptografía y datos del juego. |
| Composición | Construcción de dependencias y ciclo de vida de los procesos. |

La dirección de dependencias será hacia dominio y aplicación. La tabla no ordena crear cinco carpetas vacías; cada separación necesita código, una prueba o un consumidor real.

## Puerta antes de implementar

M0 debe fijar cliente/build, stack y primer contrato de protocolo. El commit de referencia auditado de WakBox-Evolution es `bacde4702ed871c639ea81f2179f1619beb42c0b`; su árbol no contiene una licencia general comprobable, por lo que sus fuentes no entran en esta carpeta sin permiso expreso.
