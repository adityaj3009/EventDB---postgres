-- common table expressions (CTEs)

-- basic cte which contains tickect count per show with their base price
with event_stats as (
	select
		event_id,
		count(*) as ticket_count,
		sum(price) as revenue
	from tickets
	group by event_id
)
select
	e.title,
	es.ticket_count,
	e.base_price
from events e
join event_stats es on e.id = es.event_id
order by es.revenue desc
limit 10;

-- multiple cts
-- contains oder count per user with their total and avg spent
with user_orders as (
	select
		user_id,
		count(*) as order_count,
		sum(total_amount) as total_spent
	from orders
	where status = 'paid'
	group by user_id
),
user_tickets as (
	select
		o.user_id,
		count(t.id) as ticket_count
	from orders o
	join tickets t on o.id = t.order_id
	group by o.user_id
)
select 
	u.full_name,
	uo.order_count,
	uo.total_spent, 
	round(uo.total_spent / uo.order_count, 2) as avg_order_value
from users u
join user_orders uo on u.id = uo.user_id
join user_tickets ut on u.id = ut.user_id
order by uo.total_spent desc
limit 25;