-- Pedidos v2 (17/11/2026): quién recibe el delivery y productos con precio por confirmar.
-- Se ejecuta después de 03-catalogo.sql. Se puede volver a ejecutar sin dañar nada.

alter table public.pedidos add column if not exists recibe text;
alter table public.pedidos add column if not exists recibe_tel text;
alter table public.pedidos add column if not exists por_confirmar boolean not null default false;

create or replace function public.crear_pedido(p jsonb) returns bigint
language plpgsql security definer set search_path = '' as $$
declare
  v_items jsonb := '[]'::jsonb;
  v_total numeric := 0;
  v_pc    boolean := false;
  v_num   bigint;
  v_modo  text := case when p->>'modo' = 'mitad' then 'mitad' else 'contado' end;
  it      jsonb;
  pr      record;
  q       integer;
begin
  if jsonb_typeof(p->'items') is distinct from 'array'
     or jsonb_array_length(p->'items') = 0 or jsonb_array_length(p->'items') > 50 then
    raise exception 'El pedido no tiene productos';
  end if;
  if coalesce(trim(p->>'cliente'), '') = '' or coalesce(trim(p->>'telefono'), '') = '' then
    raise exception 'Faltan el nombre o el teléfono';
  end if;
  for it in select * from jsonb_array_elements(p->'items') loop
    q := (it->>'q')::integer;
    if q is null or q < 1 or q > 99 then raise exception 'Cantidad inválida'; end if;
    select x.id, x.nombre, coalesce(x.precio_oferta, x.precio) as precio into pr
      from public.productos x
      where x.id = (it->>'id')::bigint and x.visible and x.categoria <> 'eventos';
    if not found then raise exception 'Un producto ya no está disponible'; end if;
    if pr.precio is null then v_pc := true; end if;
    v_items := v_items || jsonb_build_object('id', pr.id, 'nombre', pr.nombre, 'precio', pr.precio, 'q', q);
    v_total := v_total + coalesce(pr.precio, 0) * q;
  end loop;

  insert into public.pedidos (cliente, telefono, entrega, direccion, recibe, recibe_tel, fecha, hora, metodo, modo,
                              items, total, abonado, por_confirmar, tasa, referencia, tarjeta, nota)
  values (
    left(trim(p->>'cliente'), 120),
    left(trim(p->>'telefono'), 40),
    case when p->>'entrega' = 'pickup' then 'pickup' else 'delivery' end,
    left(p->>'direccion', 300),
    nullif(left(trim(coalesce(p->>'recibe', '')), 120), ''),
    nullif(left(trim(coalesce(p->>'recibe_tel', '')), 40), ''),
    nullif(p->>'fecha', '')::date,
    left(p->>'hora', 10),
    left(coalesce(p->>'metodo', ''), 40),
    v_modo,
    v_items, v_total,
    case when v_pc then 0 when v_modo = 'mitad' then round(v_total / 2, 2) else v_total end,
    v_pc,
    nullif(p->>'tasa', '')::numeric,
    left(p->>'referencia', 120),
    left(p->>'tarjeta', 500),
    left(p->>'nota', 1000)
  )
  returning numero into v_num;
  return v_num;
end $$;

revoke all on function public.crear_pedido(jsonb) from public;
grant execute on function public.crear_pedido(jsonb) to anon, authenticated;

select 'listo' as estado;
