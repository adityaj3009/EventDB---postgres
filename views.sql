-- views

-- simple view - (active events)
create or replace view active_events as
select
	e.id,
	e.title,
	e.start_ts,
	e.base_price,
    v.name as venue_name,
    v.city
from events e
join venues v on e.venue_id = v.id
where e.start_ts > current_timestamp;

-- usage
select * from active_events order by start_ts limit 10;