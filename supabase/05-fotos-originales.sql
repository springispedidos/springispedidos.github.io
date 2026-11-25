-- Fotos originales (24/11/2026): segundas fotos para 3 productos y 5 productos nuevos sin precio.
begin;
update public.productos set imagenes = imagenes || array['imagenes/productos/9-rosas-con-clavellinas-2.jpg'] where nombre = '9 rosas con clavellinas' and not ('imagenes/productos/9-rosas-con-clavellinas-2.jpg' = any(imagenes));
update public.productos set imagenes = imagenes || array['imagenes/productos/12-rosas-con-billetes-2.jpg'] where nombre = '12 rosas con billetes' and not ('imagenes/productos/12-rosas-con-billetes-2.jpg' = any(imagenes));
update public.productos set imagenes = imagenes || array['imagenes/productos/15-rosas-con-lirios-2.jpg'] where nombre = '15 rosas con lirios' and not ('imagenes/productos/15-rosas-con-lirios-2.jpg' = any(imagenes));
insert into public.productos (categoria, nombre, descripcion, precio, imagenes, orden, visible)
select v.c, v.n, v.d, null, array[v.i], v.o, true from (values
 ('rosas','Rosas rojas con mariposas','Rosas rojas con mariposas decorativas, follaje verde, envoltura, cinta y tarjeta dedicatoria.','imagenes/productos/rosas-rojas-con-mariposas.jpg',195),
 ('rosas','Rosas amarillas con gypso','Rosas amarillas acompañadas con gypso, follaje verde, envoltura y tarjeta dedicatoria.','imagenes/productos/rosas-amarillas-con-gypso.jpg',205),
 ('girasoles','Girasoles con chocolate','Girasoles con flores amarillas, follaje verde, chocolate, envoltura, cinta y tarjeta dedicatoria.','imagenes/productos/girasoles-con-chocolate.jpg',315),
 ('primaverales','Primaveral 4','Girasol, rosas, green ball y flores variadas, con mariposa decorativa, envoltura y tarjeta dedicatoria.','imagenes/productos/primaveral-4.jpg',385),
 ('bolsitas','Sobre amarillo','Girasoles, rosa amarilla y flores amarillas variadas en sobre decorativo con cinta y tarjeta dedicatoria.','imagenes/productos/sobre-amarillo.jpg',435)
) as v(c,n,d,i,o) where not exists (select 1 from public.productos p where p.nombre = v.n);
commit;
select count(*) as productos from public.productos;
