create or replace function getDoc(phrase varchar)
	returns setof film as
	$$
		select *
		from film
		where to_tsvector(description) @@ plainto_tsquery(phrase);
	$$ language sql;
select *
from getDoc('boy')
