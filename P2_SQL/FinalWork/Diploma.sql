-- 1. В каких городах больше одного аэропорта?
select
	city,
	count(airport_code) as airport_count
from
	bookings.airports
group by city
having
	count(airport_code) > 1;


-- 2. Были ли брони, по которым не совершались перелеты?
select
	distinct book_ref
from
	bookings.tickets
	left join bookings.bookings using (book_ref)
	right join bookings.ticket_flights using (ticket_no)
	left join bookings.flights using (flight_id)
where
	actual_arrival is null;


-- 3. В каких аэропортах есть рейсы, которые обслуживаются самолетами с максимальной дальностью перелетов?
with max_range_plane as (
select
	aircraft_code
from
	bookings.aircrafts
order by range desc
limit 1
),
max_plane_airports as (
select
	departure_airport as airport_code
from
	bookings.flights
where
	aircraft_code in (select aircraft_code from max_range_plane)
union all
select
	arrival_airport as airport_code
from
	bookings.flights
where
	aircraft_code in (select aircraft_code from max_range_plane)
)
select
	distinct airport_name
from
	max_plane_airports
	left join bookings.airports using (airport_code);


-- 4. Между какими городами пассажиры делали пересадки?
with ways as (
select
	ticket_no,
	da.city as dep_city,
	aa.city as arr_city,
	first_value(da.city) over (partition by ticket_no order by actual_departure asc)
	|| ' - ' ||
	first_value(aa.city) over (partition by ticket_no order by actual_departure desc) as route
from
	bookings.ticket_flights
	left join bookings.flights as f using (flight_id)
	left join bookings.airports as da on(f.departure_airport=da.airport_code)
	left join bookings.airports as aa on(f.arrival_airport=aa.airport_code)
order by ticket_no asc, actual_departure asc
),
transfer as (
select ticket_no
from ways
group by ticket_no
having count(ticket_no) > 1
)
select
	distinct route
from
	ways
where
	ticket_no in (select ticket_no from transfer);

-- 4.1 При полетах между какими городами делают пересадки чаще?
with ways as (
select
	ticket_no,
	da.city as dep_city,
	aa.city as arr_city,
	first_value(da.city) over (partition by ticket_no order by actual_departure asc)
	|| ' - ' ||
	first_value(aa.city) over (partition by ticket_no order by actual_departure desc) as route
from
	bookings.ticket_flights
	left join bookings.flights as f using (flight_id)
	left join bookings.airports as da on(f.departure_airport=da.airport_code)
	left join bookings.airports as aa on(f.arrival_airport=aa.airport_code)
order by ticket_no asc, actual_departure asc
),
transfer as (
select ticket_no
from ways
group by ticket_no
having count(ticket_no) > 1
)
select
	route,
	count(distinct ticket_no) as transfer_count
from
	ways
where
	ticket_no in (select ticket_no from transfer)
group by route
order by transfer_count desc;


-- 4.2 Какие города используют для пересадок чаще?
with ways as (
select
	ticket_no,
	da.city as dep_city,
	aa.city as arr_city,
	first_value(da.city) over (partition by ticket_no order by actual_departure asc) as start_city,
	first_value(aa.city) over (partition by ticket_no order by actual_departure desc) as finish_city
from
	bookings.ticket_flights
	left join bookings.flights as f using (flight_id)
	left join bookings.airports as da on(f.departure_airport=da.airport_code)
	left join bookings.airports as aa on(f.arrival_airport=aa.airport_code)
order by ticket_no asc, actual_departure asc
),
transfer as (
select ticket_no
from ways
group by ticket_no
having count(ticket_no) > 1
)
select
	arr_city,
	count(case when arr_city != finish_city then ticket_no else null end) as transfer_count
from
	ways
where
	ticket_no in (select ticket_no from transfer)
group by arr_city
order by transfer_count desc;
