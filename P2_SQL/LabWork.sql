-- Cоставить список клиентов по имени и фамилии вместе с их адресом электронной почты,
-- чтобы отправить благодарность 5 самым дорогим клиентам, которые арендовали фильмы с 10 по 13 апреля
select
	first_name,
	last_name,
	email,
	address
from
	payment as r
	left join customer using (customer_id)
	left join address using (address_id)
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
