-- revenue trend analysis
with daily_revenue as (
	select
		date(created_at) as order_date,
		sum(total_amount) as daily_revenue,
		count(*) as order_count
	from orders
	where status = 'paid'
	group by date(created_at)
)
select
	order_date,
	daily_revenue,
	order_count,
	avg(daily_revenue) over (
		order by order_date
		rows between 6 preceding and current row
	) as moving_avg_7day,
	sum(daily_revenue) over (
		order by order_date
	) as cumulative_revenue,
	lag(daily_revenue, 7) over (order by order_date) as revenue_7days_ago,
	round(
		100.0* (daily_revenue - lag(daily_revenue,7) over (order by order_date))
		/ nullif (lag(daily_revenue,7) over (order by order_date), 0),2
	) as week_over_over_growth
from daily_revenue
order by order_date desc
limit 20;