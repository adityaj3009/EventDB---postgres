-- aggregations
select * from events limit 5;
select 
	count(*) as total_orders,
	sum(total_amount) as total_amount,
	avg(total_amount) as avg_amount,
	min(total_amount) as min_amount,
	max(total_amount) as max_amaount
from orders;

--aggregation (events by price range)
select
	case
		when base_price < 1000 then 'Budget'
		when base_price between 1000 and 2000 then 'Mid Range'
		else 'Premium'
	end as price_category,
	count(*) as event_count,
	avg(base_price) as avg_price
from events
group by price_category
order by avg_price;

-- group by
select
	status,
	count(*) as order_count,
	sum(total_amount) as total_revenue
from orders
group by status;

select 
	city,
	count(*) as venue_count
from venues
group by city
order by venue_count desc;

-- having clause
select
	city,
	count(*) as venue_count
from venues
group by city
having count(*)>2
order by venue_count desc;