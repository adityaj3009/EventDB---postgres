-- user defined function

-- Calculate ticket service fee
create or replace function calculate_service_fee(ticket_price numeric)
returns numeric as $$
begin
    return round(ticket_price * 0.15, 2);  -- 15% service fee
end;
$$ language plpgsql;

-- usage
select 
    id,
    price,
    calculate_service_fee(price) as service_fee,
    price + calculate_service_fee(price) as total_price
from tickets
limit 10;


-- function with conditional logic 
create or replace function get_customer_tier(total_spent numeric)
returns text as $$
begin
    if total_spent >= 10000 then
        return 'platinum';
    elsif total_spent >= 5000 then
        return 'gold';
    elsif total_spent >= 2000 then
        return 'silver';
    else
        return 'bronze';
    end if;
end;
$$ language plpgsql;

-- usage
with customer_spending as (
    select 
        u.id,
        u.full_name,
        coalesce(sum(o.total_amount), 0) as total_spent
    from users u
    left join orders o on u.id = o.user_id and o.status = 'paid'
    group by u.id, u.full_name
)
select 
    full_name,
    total_spent,
    get_customer_tier(total_spent) as tier
from customer_spending
order by total_spent desc
limit 20;

-- function returning table - get user statistics
create or replace function get_user_stats(user_id_param int)
returns table (
    total_orders bigint,
    total_spent numeric,
    total_tickets bigint,
    avg_order_value numeric,
    last_order_date timestamptz
) as $$
begin
    return query
    select 
        count(distinct o.id)::bigint,
        coalesce(sum(o.total_amount), 0),
        count(t.id)::bigint,
        coalesce(avg(o.total_amount), 0),
        max(o.created_at)
    from orders o
    left join tickets t on o.id = t.order_id
    where o.user_id = user_id_param and o.status = 'paid';
end;
$$ language plpgsql;

-- usage
select * from get_user_stats(1);
