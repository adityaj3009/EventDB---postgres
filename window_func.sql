-- window functions

-- row_number - ranking event by  price
select 
	title,
	base_price,
	row_number() over (order by base_price desc) as price_rank
from events
limit 10;

-- rank and dense_rank
select
	city,
	name,
	rank() over (partition by city order by name) as rank,
	dense_rank() over (partition by city order by name) as dense_rank
from venues
order by city, rank
limit 10;

-- divide event into quartiles
select 
	title,
	base_price,
	ntile(4) over (order by base_price) as price_quartile
from events
order by base_price desc;

-- running total with sum
select
	created_at::date as order_date,
	total_amount,
	sum(total_amount) over (order by created_at) as running_total
from orders
where status = 'paid'
order by created_at
limit 10;

-- moving average
select
	created_at::date as order_date,
	total_amount,
	avg(total_amount) over (order by created_at
							rows between 6 preceding and current row
						    ) as moving_avg_7days
from orders
where status = 'paid'
order by created_at
limit 10;

-- lag and lead
select 
	title,
	base_price,
	lag(base_price) over (order by start_ts) as prev_even_price,
	lead(base_price) over (order by start_ts) as next_even_price
from events
order by start_ts
limit 10;

-- partition by
select
	v.city,
	e.title,
	e.base_price,
	row_number() over (partition by v.city order by e.base_price desc) as city_price_rank
from events e
join venues v on e.venue_id = v.id
order by v.city, city_price_rank
limit 20;