-- Pagos con abono del 50 % o completo, referencia y tasa euro. Se ejecuta después de esquema.sql.
-- Se puede volver a ejecutar sin dañar nada.

alter table public.pedidos add column if not exists modo text not null default 'contado';
alter table public.pedidos add column if not exists abonado numeric(10,2) not null default 0;
alter table public.pedidos add column if not exists tasa numeric;
alter table public.pedidos add column if not exists referencia text;
alter table public.pedidos drop constraint if exists pedidos_modo_check;
alter table public.pedidos add constraint pedidos_modo_check check (modo in ('mitad','contado'));

create or replace function public.crear_pedido(p jsonb) returns bigint
language plpgsql security definer set search_path = '' as $$
declare
  v_items jsonb := '[]'::jsonb;
  v_total numeric := 0;
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
      where x.id = (it->>'id')::bigint and x.visible and x.precio is not null and x.categoria <> 'eventos';
    if not found then raise exception 'Un producto ya no está disponible'; end if;
    v_items := v_items || jsonb_build_object('id', pr.id, 'nombre', pr.nombre, 'precio', pr.precio, 'q', q);
    v_total := v_total + pr.precio * q;
  end loop;

  insert into public.pedidos (cliente, telefono, entrega, direccion, fecha, hora, metodo, modo,
                              items, total, abonado, tasa, referencia, tarjeta, nota)
  values (
    left(trim(p->>'cliente'), 120),
    left(trim(p->>'telefono'), 40),
    case when p->>'entrega' = 'pickup' then 'pickup' else 'delivery' end,
    left(p->>'direccion', 300),
    nullif(p->>'fecha', '')::date,
    left(p->>'hora', 10),
    left(coalesce(p->>'metodo', ''), 40),
    v_modo,
    v_items, v_total,
    case when v_modo = 'mitad' then round(v_total / 2, 2) else v_total end,
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
