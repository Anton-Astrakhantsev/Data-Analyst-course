
-- Выведите магазины, имеющие больше 300-от покупателей
select
	store_id,
	count(distinct customer_id)
from
	rental
	left join staff using (staff_id)
group by store_id
having
	count(distinct customer_id) > 300;


-- Выведите у каждого покупателя город в котором он живет
select
	customer_id,
	city
from
	customer as cus
	left join address as adr on(cus.address_id=adr.address_id)
	left join city using(city_id);
