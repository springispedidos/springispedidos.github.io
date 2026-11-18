# Notas del proyecto: web de Springis

Resumen para retomar el trabajo en otra conversación.

## Qué es
Floristería y tienda virtual: ramilletes, arreglos, flores en caja, centros de mesa y decoración de eventos (bodas, bautizos, cumpleaños, etc.). La web es un catálogo estilo app de pedidos («pide fácil»): fotos, precios, botón + para agregar, barra flotante con el total y pedido por WhatsApp. Tiene una sección de Eventos con formulario de cotización.

## Enlaces
- Web: https://springispedidos.github.io/
- Panel de admin (no aparece enlazado en la web): https://springispedidos.github.io/admin.html
- Repositorio: https://github.com/springispedidos/springispedidos.github.io (organización «springispedidos», administrada desde la cuenta Viphydetails)
- Regla: Springis vive en su propio repositorio y su propio Supabase. Nunca se toca el repositorio `viphydetails.github.io` ni el Supabase de Viphy desde este proyecto.

## Archivos
- `supabase/03-catalogo.sql` (ya ejecutado el 17/11/2026): secciones Rosas, Girasoles, Primaverales, Bolsitas, Cajitas y box, Otras opciones (+ Galería de eventos) y 49 productos sin precio. Fotos en `imagenes/productos/` (sacadas del PDF sin recomprimir; «5 girasoles decorados» recortada de la página). `imagenes/historia.jpg` es la foto de la portada del catálogo.
- `index.html`: toda la web para clientes. Arriba del script está `CONFIG` (WhatsApp, Instagram, ciudad, horario, logo, foto de portada, métodos de pago), los tipos de evento (`EVENTOS`), los servicios y rangos de presupuesto de la cotización, las preguntas frecuentes (`FAQ`) y la lista de productos de respaldo (`PRODUCTOS`, con precios de ejemplo).
- `admin.html`: panel con pestañas Productos, Secciones, Pedidos y Cotizaciones. Sale «Falta conectar» mientras Supabase no esté configurado.
- `compartido.js`: datos de Supabase (vacíos por ahora) y secciones de respaldo. Si se cambia, sube el número en `compartido.js?v=N` dentro de index.html y admin.html.
- `supabase/esquema.sql`: crea todo de una vez (admins, secciones, productos, fotos, pedidos con `crear_pedido`, cotizaciones con `crear_cotizacion`).

## Decisiones
- 2026-11-16: rediseño con estilo de referencia elegante (crema, verde oliva, Cormorant Garamond + Jost, portada con foto grande, categorías, historia, franja verde de beneficios). Mientras no haya fotos se ven dibujos de línea.
- Pagos como en Viphy pero con datos propios: abono del 50 % para agendar (el resto antes del envío) o pago completo. Métodos: pago móvil (Mercantil, 11.816.381, 0412-8666669) en Bs a tasa euro BCV con botón «Copiar datos y monto», Zelle (a consultar) y efectivo. Referencia obligatoria solo en pago móvil. Delivery aparte según zona; se pide la ubicación GPS por WhatsApp.
- Tasa euro BCV: `tasa.json`, la actualiza sola `.github/workflows/tasa.yml` (7:00 a. m. y 6:00 p. m. Caracas) con `scripts/actualizar-tasa.mjs`. Copia propia de Springis, independiente de Viphy.
- `supabase/02-pagos.sql` (ya ejecutado): columnas modo, abonado, tasa y referencia en pedidos.
- WhatsApp 0414-4980997, Instagram @springis.val_, Valencia.
- Sin emojis en ninguna parte (la dueña siente que le quitan seriedad). Sin foto, los productos muestran una flor dibujada en línea; en el panel, la inicial.
- Identidad (16/11/2026): el turquesa debe PREDOMINAR (portada, barra de tasa, botones, carrito, pie, franja en turquesa claro); el verde #265B3D solo en detalles (logo, enlaces, cifras). Turquesa #65B79F, turquesa secundario #9EC9B7 (confirmado por la dueña), blanco y negro; sobre turquesa las letras van en negro. Sin degradados. Títulos en Anton (Google Fonts, pedido por la dueña el 17/11/2026 en lugar de Rosemartin); texto en Jost hasta saber la secundaria. Logo: `imagenes/logo-color.png` y `logo-blanco.png`, sacados del .ai con colores planos.
- Precios en USD. El delivery se confirma aparte por WhatsApp; los datos de pago también se envían por WhatsApp (la web solo pregunta cómo prefiere pagar).
- El pedido incluye mensaje para la tarjeta y notas.
- La sección `eventos` («Galería de eventos») es especial: sus fotos no se venden, salen en la parte de Eventos con el botón «Quiero algo así», que abre la cotización con esa foto como referencia.
- Cotizaciones: estados Nueva, Conversando, Cotizada, Confirmada, Realizada, Descartada. El admin anota el monto cotizado y notas internas.
- Panel: se entra con usuario y contraseña. Por dentro cada usuario es «usuario@springis.invalid» (dominio reservado, no recibe correos). Para crear uno: Supabase → Authentication → Users → Add user con ese correo y Auto Confirm, y luego `insert into public.admins (email) values ('usuario@springis.invalid');`. La contraseña olvidada se cambia desde Supabase (no hay correo de recuperación).
- Si Supabase falla o no está configurado, pedidos y cotizaciones igual llegan por WhatsApp, solo que sin número.

## Pendiente
- Logo en PNG (va en `imagenes/` y en `CONFIG.logo`).
- Usuario de Instagram, colores y tipografías de la marca.
- Fotos de portada, categorías e historia; tipografía secundaria; textos de los 4 beneficios; horario.
- Precios de los 49 productos del catálogo (se ponen en el panel; sin precio salen «Precio por confirmar»).
- Fotos originales en mejor calidad: las del PDF del catálogo solo llegan a 300×400 px.
- Supabase conectado (proyecto «Springis», https://zierdhzzdmankvgcyfjs.supabase.co, esquema ya ejecutado). Admin «sophia» creada y con permiso; registro público desactivado.
- Mientras no haya productos cargados en el panel, la web muestra los de ejemplo de `index.html`.
- Fotos, nombres y precios reales (se cargan desde el panel cuando esté conectado).
- Fotos de eventos ya decorados para la galería.
