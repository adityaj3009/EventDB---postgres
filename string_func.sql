-- string function

-- String manipulation
select
	full_name,
	upper(full_name) as uppercaste,
	lower(full_name) as lowerrcase,
	length(full_name) as name_length,
	split_part(full_name, ' ',1) as first_name,
	split_part(full_name, ' ', 2) as last_name
from users
limit 10;

-- String concatenation
select
	title,
	replace(title, 'Annual', 'Yearly') as modified_title,
	position('Music' in title) as music_position ,
	substring(title,1,20) as short_title
from events;