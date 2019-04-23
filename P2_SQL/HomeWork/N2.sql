
-- Вывести всех неактивных покупателей
select
	*
from
	public.customer
where
	active = 0;


--Вывести 10 последних платежей за прокат фильмов
select
	*
from
	public.payment
order by
	payment_date desc,
	payment_id desc
limit 20;
