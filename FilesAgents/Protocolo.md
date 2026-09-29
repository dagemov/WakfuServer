# Protocolo

## Estado

No existe todavía una captura o conexión ejecutada con el cliente objetivo. Los datos siguientes son límites de trabajo, no resultados de integración.

## Evidencia estática inicial

- WakBox-Evolution declara compatibilidad con Wakfu 1.54.0.
- La revisión inspeccionada contiene rutas relacionadas con creación, guardado y entrada del personaje.
- Los campos, identificadores, estados y orden exactos deben verificarse con el cliente elegido.

## Registro de hallazgos

Cada hallazgo futuro debe incluir:

| Campo | Descripción |
|---|---|
| Estado de sesión | Punto del recorrido donde aparece |
| Dirección | Cliente a servidor o servidor a cliente |
| Identificador | Valor comprobado y representación |
| Framing | Longitud, cabecera, endianness y límites |
| Campos | Orden, tipo y significado observado |
| Evidencia | Código, log o captura local concreta |
| Confianza | Ejecutado, estático, hipótesis o pendiente |
| Siguiente prueba | Dato que falta confirmar |

## Preguntas abiertas de M0–M2

- ¿Cómo configura el cliente 1.54.0 sus destinos de autenticación y mundo?
- ¿Qué servicios auxiliares exige antes del primer intercambio útil?
- ¿Cuál es el framing real y qué versión o build anuncia?
- ¿Qué partes del candidato son respuestas fijas, incompletas o dependientes de datos ausentes?

Los logs crudos y las capturas viven en rutas locales ignoradas por Git. Este documento conserva únicamente hallazgos depurados que se pueden explicar y reproducir.
