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
- Pedidos v2 (17/11/2026): todos los productos tienen «Añadir al carrito», aunque no tengan precio (salen «Precio por confirmar» y el monto se confirma por WhatsApp). El formulario pide: datos del cliente; entrega (delivery con dirección, nombre y teléfono de quien recibe, y nota para anexar la ubicación GPS) o retiro; fecha y hora de entrega; tarjeta dedicatoria; pago (abono 50 % o completo, método, referencia); notas adicionales al final. El WhatsApp empieza «¡Hola! Mi nombre es …, este es mi pedido número #001» (número de 3 cifras desde #001). `supabase/04-pedidos-v2.sql` ya ejecutado (columnas recibe, recibe_tel, por_confirmar). Se probó con un pedido de prueba que luego se borró y el contador se reinició a #001.
- 2026-11-16: rediseño con estilo de referencia elegante (crema, verde oliva, Cormorant Garamond + Jost, portada con foto grande, categorías, historia, franja verde de beneficios). Mientras no haya fotos se ven dibujos de línea.
- Pagos como en Viphy pero con datos propios: abono del 50 % para agendar (el resto antes del envío) o pago completo. Métodos: pago móvil (Mercantil, 11.816.381, 0412-8666669) en Bs a tasa euro BCV con botón «Copiar datos y monto», Zelle (a consultar) y efectivo. Referencia obligatoria solo en pago móvil. Delivery aparte según zona; se pide la ubicación GPS por WhatsApp.
- Tasa euro BCV: `tasa.json`, la actualiza sola `.github/workflows/tasa.yml` (7:00 a. m. y 6:00 p. m. Caracas) con `scripts/actualizar-tasa.mjs`. Copia propia de Springis, independiente de Viphy.
- `supabase/02-pagos.sql` (ya ejecutado): columnas modo, abonado, tasa y referencia en pedidos.
- WhatsApp 0414-4980997, Instagram @springis.val_, Valencia.
- Transiciones (17/11/2026): entrada escalonada de la portada y la rama que se dibuja sola; secciones y tarjetas aparecen al bajar (IntersectionObserver con respaldo por scroll; sin JS o con «reducir movimiento» todo se ve normal); tarjetas, categorías y botones se elevan al pasar el mouse; ficha con apertura suave; el contador del carrito salta al agregar; la cifra +5.000 cuenta desde 0.
- Animaciones de aparición: UNA sola vez (la dueña probó repetirlas y le causaron mareo, 17/11/2026).
- Encabezado: al bajar más de 60 px se vuelve translúcido con desenfoque (vidrio) y más delgado (58 px, logo 40 px); al pasar el mouse vuelve a ser blanco.
- Portada (17/11/2026): foto del equipo (`imagenes/portada.jpg`, copia en diseno-redes/marcas/springis/fotos/equipo-portada.jpg). Se ve COMPLETA de fondo a todo lo ancho (el alto sigue la proporción de la foto) con las letras en blanco al frente, abajo a la izquierda para no tapar las caras. En el teléfono: foto completa arriba con el título blanco encima, y el texto y los botones debajo sobre turquesa.
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
- Fotos de categorías (opcional); tipografía secundaria; textos de los 4 beneficios; horario.
- Precios de los 49 productos del catálogo (se ponen en el panel; sin precio salen «Precio por confirmar»).
- Fotos originales (24/11/2026): 25 productos ya tienen la foto original (1200×1600, sin GPS); `supabase/05-fotos-originales.sql` (ejecutado) añadió segundas fotos a 3 productos y 5 productos nuevos (54 en total). Quedan con foto del PDF los que no vinieron en esa carpeta.
- Sección «Clientes felices» (24/11/2026): entre la franja de beneficios y Eventos; 3 fotos en `imagenes/clientes/`, lista en `CONFIG.fotosClientes` (para agregar más, se sube la foto y se añade ahí). En el teléfono se deslizan de lado.
- Supabase conectado (proyecto «Springis», https://zierdhzzdmankvgcyfjs.supabase.co, esquema ya ejecutado). Admin «sophia» creada y con permiso; registro público desactivado.
- Mientras no haya productos cargados en el panel, la web muestra los de ejemplo de `index.html`.
- Fotos, nombres y precios reales (se cargan desde el panel cuando esté conectado).
- Fotos de eventos ya decorados para la galería.
