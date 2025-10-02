-- real word bussiness questions?

-- Q1: What are the top 10 most profitable events?
select
	e.title,
	v.name as venue,
	count(t.id) as ticket_sold,
	sum(t.price) as revenue,
	e.base_price,
	round((sum(t.price)- e.base_price * count(t.id)) / count(t.id),2) as profit_per_ticket
from events e
join venues v on e.venue_id = v.id
join tickets t on e.id = t.event_id
group by e.id, e.title, v.name, v.city, e.base_price
order by revenue desc
limit 10;

-- Q2: Which cities generate the most revenue?
select
	v.city,
	count(distinct e.id) as total_events,
	count(t.id) as tickets_sold,
	sum(t.price) as total_revenue,
	avg(t.price) as avg_ticket_price
from venues v
join events e on v.id = e.venue_id
join tickets t on e.id = t.event_id
group by v.city
order by total_revenue desc;

-- Q3: Customer purchase patterns by day of week
select 
	to_char(created_at, 'Day') as day_name,
	extract(dow from created_at) as day_number,
	count(*) as order_count,
	sum(total_amount) as revenue,
	avg(total_amount) as avg_order_value
from orders
where status = 'paid'
group by day_name, day_number
order by day_number;

-- Q4: Attendance funnel analysis
select
	action,
	count(*) as count,
	round(100.0 * count(*) /sum(count(*)) over(),2) as percentage
from attendance_log
group by action
order by count desc;

-- Q5: Top customers with their favorite event types
with customer_events as (
	select 
		u.id,
		u.full_name,
		e.title,
		count(*) as event_attendance,
		sum(t.price) as total_spent
	from users u
	join orders o on u.id = o.user_id
	join tickets t on o.id = t.order_id
	join events e on t.event_id = e.id
	group by u.id , u.full_name, e.title
),
ranked_events as (
	select
		*,
		row_number() over (partition by id order by event_attendance desc) as rank
	from customer_events
)
select
	full_name,
	title as fav_event,
	event_attendance,
	total_spent
from ranked_events
where rank=1
order by total_spent desc
limit 20;
