-- joins combining tables

-- inner join
select
	e.title,
	v.name as venues_name,
	v.city
from events e
inner join venues v on e.venue_id = v.id
limit 10;

--multiple join
select 
	u.full_name as customer,
	o.id as order_id,
	e.title as event_name,
	o.total_amount,
	o.status,
	t.seat
from users u
join orders o on u.id = o.user_id
join tickets t on o.id = t.order_id
join events e on t.event_id = e.id
limit 25;

-- left join
select 
	u.full_name,
	count(o.id) as total_orders,
	coalesce(sum(o.total_amount),0) as total_spent
from users u
left join orders o on u.id = o.user_id
group by u.id, u.full_name
order by total_spent desc
limit 25;

-- complex join
select 
	v.city,
	count(distinct e.id) as total_events,
	count(t.id) as tickets_sold,
	sum(t.price) as revenue
from venues v
join events e on v.id = e.venue_id
left join tickets t on e.id = t.event_id
group by v.city
order by revenue desc;

