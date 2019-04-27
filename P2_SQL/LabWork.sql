
-- Cоставить список клиентов по имени и фамилии вместе с их адресом электронной почты,
-- чтобы отправить благодарность 5 самым дорогим клиентам, которые арендовали фильмы с 10 по 13 апреля
select
	first_name,
	last_name,
	concat('email address is ', email) as email
from
	payment as r
	left join customer using (customer_id)
where
	payment_date::date between '2007-04-10' and '2007-04-13'
group by first_name, last_name, email, address
order by sum(amount) desc
limit 5;


-- Какова средняя арендная ставка для каждого жанра?
-- (упорядочить по убыванию, среднее значение округлить до сотых)
select
	c.name,
	round(avg(amount),2) as avg_pay
from
	payment as p
	left join rental as r using (rental_id)
	left join inventory as i using (inventory_id)
	left join film_category as fc using (film_id)
	left join category as c using (category_id)
group by c.name
order by avg_pay desc


-- Сколько арендованных фильмов было возвращено в срок, до срока возврата и после,
-- выведите максимальную разницу со сроком?
with rental_scheme as (
select
	rental_id,
	rental_duration as dur,
	extract(day from return_date - rental_date) as back
from
	rental as r
	left join inventory as i using (inventory_id)
	left join film as f using (film_id)
)
select
	count(case when back = dur then rental_id else null end) as return_in_line,
	count(case when back < dur then rental_id else null end) as return_before_line,
	count(case when back > dur then rental_id else null end) as return_after_line,
	max(back - dur) as max_late_return
from
	rental_scheme
