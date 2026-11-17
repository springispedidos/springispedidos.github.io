# Notas del proyecto: web de Springis

Resumen para retomar el trabajo en otra conversación.

## Qué es
Floristería y tienda virtual: ramilletes, arreglos, flores en caja, centros de mesa y decoración de eventos (bodas, bautizos, cumpleaños, etc.). La web es un catálogo estilo app de pedidos («pide fácil»): fotos, precios, botón + para agregar, barra flotante con el total y pedido por WhatsApp. Tiene una sección de Eventos con formulario de cotización.

## Enlaces
- Web: https://viphydetails.github.io/springis/
- Panel de admin (no aparece enlazado en la web): https://viphydetails.github.io/springis/admin.html
- Repositorio: https://github.com/Viphydetails/springis (cuenta de GitHub de Viphy, repositorio aparte)
- Regla: Springis vive en su propio repositorio y su propio Supabase. Nunca se toca el repositorio `viphydetails.github.io` ni el Supabase de Viphy desde este proyecto.

## Archivos
- `index.html`: toda la web para clientes. Arriba del script está `CONFIG` (WhatsApp, Instagram, ciudad, horario, logo, foto de portada, métodos de pago), los tipos de evento (`EVENTOS`), los servicios y rangos de presupuesto de la cotización, las preguntas frecuentes (`FAQ`) y la lista de productos de respaldo (`PRODUCTOS`, con precios de ejemplo).
- `admin.html`: panel con pestañas Productos, Secciones, Pedidos y Cotizaciones. Sale «Falta conectar» mientras Supabase no esté configurado.
- `compartido.js`: datos de Supabase (vacíos por ahora) y secciones de respaldo. Si se cambia, sube el número en `compartido.js?v=N` dentro de index.html y admin.html.
- `supabase/esquema.sql`: crea todo de una vez (admins, secciones, productos, fotos, pedidos con `crear_pedido`, cotizaciones con `crear_cotizacion`).

## Decisiones
- Colores y tipografías provisionales (rosa #b8476a, verde hoja #3f6b4f, crema #fbf7f3; Fraunces y DM Sans) hasta tener los de la marca.
- Precios en USD. El delivery se confirma aparte por WhatsApp; los datos de pago también se envían por WhatsApp (la web solo pregunta cómo prefiere pagar).
- El pedido incluye mensaje para la tarjeta y notas.
- La sección `eventos` («Galería de eventos») es especial: sus fotos no se venden, salen en la parte de Eventos con el botón «Quiero algo así», que abre la cotización con esa foto como referencia.
- Cotizaciones: estados Nueva, Conversando, Cotizada, Confirmada, Realizada, Descartada. El admin anota el monto cotizado y notas internas.
- Si Supabase falla o no está configurado, pedidos y cotizaciones igual llegan por WhatsApp, solo que sin número.

## Pendiente
- Logo en PNG (va en `imagenes/` y en `CONFIG.logo`).
- Usuario de Instagram, colores y tipografías de la marca.
- Número de WhatsApp (sin él, el chat se abre sin destinatario).
- Ciudad, horario, métodos de pago reales.
- Supabase conectado (proyecto «Springis», https://zierdhzzdmankvgcyfjs.supabase.co, esquema ya ejecutado). Falta: crear la cuenta de admin, agregarla a la tabla `admins` y desactivar el registro público.
- Mientras no haya productos cargados en el panel, la web muestra los de ejemplo de `index.html`.
- Fotos, nombres y precios reales (se cargan desde el panel cuando esté conectado).
- Fotos de eventos ya decorados para la galería.
