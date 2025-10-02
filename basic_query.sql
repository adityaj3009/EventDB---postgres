-- see whether data is imported properly
select * from attendance_log limit 5;
select * from events limit 5;
select * from orders limit 5;
select * from tickets limit 5;
select * from venues limit 5;
select * from users limit 5;

-- where clause 
select title, base_price, tags
from events
where base_price < 3000;

select venue_id,title, base_price
from events
where base_price > 2000 and base_price < 4000;

-- between
select title, base_price
from events
where base_price between 2000 and 4000;

-- in operator
select * from venues
where city in ('Mumbai', 'Kolkata', 'Delhi');

-- pattern matching
select full_name, email
from users
where full_name like 'A%'; -- name starts with A

select title from events
where title like '%Music%';  -- event with music word in title

-- not
select * from orders
where status != 'cancelled';

-- order by
select title, base_price
from events
order by base_price desc
limit 10;

-- distinct
select distinct city from venues;

-- count
select count(*) as total_users from users;
select count(*) as total_events from events;


