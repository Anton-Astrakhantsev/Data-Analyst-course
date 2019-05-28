create table film_annotation (
  film_id integer primary key,
  annotation varchar
);

insert into film_annotation values
('1', '- Кто свидетель? Я! А что случилось?'),
('2', '- Какое горе! Принцесса Диана была так молода и красива! Будь она старой и страшной — было бы не так плохо?'),
('3', 'Есть такая история про Париж и людей, умиравших от голода во время войны. Они все сидели вокруг стола, и в тишине кто-то сказал: «Ангел пролетает», а кто-то другой сказал: «Давайте его съедим»'),
('4', '- Кто свидетель? Я! А что случилось?'),
('5', '- Какое горе! Принцесса Диана была так молода и красива! Будь она старой и страшной — было бы не так плохо?'),
('6', 'Есть такая история про Париж и людей, умиравших от голода во время войны. Они все сидели вокруг стола, и в тишине кто-то сказал: «Ангел пролетает», а кто-то другой сказал: «Давайте его съедим»');

--DROP FUNCTION getDoc(in phrase varchar);
create or replace function getDoc(phrase varchar)
	returns setof film as
	$$
	begin
		perform film_id, fulltext 
		from film
		where fulltext @@ plainto_tsquery(phrase);
	end
	$$ language plpgsql;
select *
from getDoc('arc mad')

DROP FUNCTION getDoc(in phrase varchar);
create or replace function getDoc(phrase varchar)
	returns setof film as
	$$
	begin
		perform film_id, fulltext 
		from film
		where to_tsvector(special_features) @@ to_tsvector(phrase);
	end
	$$ language plpgsql;
select *
from getDoc('{Trailers,Commentaries,"Behind the Scenes"}')
