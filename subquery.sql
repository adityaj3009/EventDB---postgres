-- subquery

select title, base_price
from events
where base_price > (select avg(base_price) from events);

-- with select clause
select
	title, base_price,
	(select avg(base_price) from events) as avg_price,
	base_price - (select avg(base_price) from events) as price_diff
from events
order by price_diff desc
limit 15;

-- with in
select full_name, email
from users
where id in (
	select distinct user_id
	from orders
	where status = 'paid'
);

-- correlated subquery
-- for finding which show has sold how much tickets
select 
	e.title,
	e.base_price,
	(select count(*)
	from tickets t
	where t.event_id = e.id) as ticket_sold
from events e
order by ticket_sold desc
limit 10;

-- subquery in from clause
-- how much avg ticket each city holds
select 
    city,
    avg_tickets
from (
    select 
        v.city,
        avg(ticket_count) as avg_tickets
    from venues v
    join events e on v.id = e.venue_id
    join (
        select event_id, count(*) as ticket_count
        from tickets
        group by event_id
    ) t on e.id = t.event_id
    group by v.city
) city_stats
where avg_tickets > 3
order by avg_tickets desc;

