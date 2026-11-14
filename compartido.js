/* Datos que usan la tienda (index.html) y el panel de admin (admin.html). */

// Proyecto de Supabase de Springis. La clave es la «publishable» (pública): puede ir en la web.
// Mientras url esté vacía, la tienda usa la lista de respaldo de index.html y los pedidos
// y cotizaciones llegan solo por WhatsApp (sin número).
const SUPABASE = {
  url: "",
  key: "",
  bucket: "productos"
};

// Secciones de respaldo. Las reales se editan en el panel (admin.html → Secciones).
// La sección «eventos» es especial: sus fotos no se venden, se muestran en la galería de Eventos.
let CATS = [
  {id:"ramilletes", n:"Ramilletes", e:"💐"},
  {id:"arreglos",   n:"Arreglos florales", e:"🌷"},
  {id:"cajas",      n:"Flores en caja", e:"🎁"},
  {id:"centros",    n:"Centros de mesa", e:"🕯️"},
  {id:"eventos",    n:"Galería de eventos", e:"📸"}
];
