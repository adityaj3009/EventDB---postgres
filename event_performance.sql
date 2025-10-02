-- event performance dashboard

with event_metrics as(
	select
		e.id,
        e.title,
        e.base_price,
        v.name as venue,
        v.city,
		count(t.id) as tickets_sold,
		sum(t.price) as revenue,
		count(distinct o.user_id) as unique_customers,
		avg(t.price) as avg_ticket_price
	from events e
	join venues v on e.venue_id = v.id
	left join tickets t on e.id = t.event_id
	left join orders o on t.order_id =o.id
	group by e.id, e.title, e.base_price, v.name, v.city
)
select
	title,
	venue,
	city,
	tickets_sold,
	revenue,
	unique_customers,
	round(revenue / nullif(tickets_sold, 0), 2) as revenue_per_tickets,
	round((tickets_sold::numeric / unique_customers),2) as tickets_per_customer,
	dense_rank() over (order by revenue desc) as revenue_rank
from event_metrics
where tickets_sold > 0
order by revenue desc
limit 20;