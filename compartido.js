/* Datos que usan la tienda (index.html) y el panel de admin (admin.html). */

// Proyecto de Supabase de Springis. La clave es la «publishable» (pública): puede ir en la web.
// Si Supabase no responde, la tienda usa la última lista guardada o la de respaldo de index.html,
// y los pedidos y cotizaciones llegan igual por WhatsApp (sin número).
const SUPABASE = {
  url: "https://zierdhzzdmankvgcyfjs.supabase.co",
  key: "sb_publishable_Oxpggbn5zFQ_maHfNrI7QQ_QNA42B5u",
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
