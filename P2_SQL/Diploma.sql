-- 1. В каких городах больше одного аэропорта?
select
	city,
	count(airport_code) as airport_count
from
	bookings.airports
group by city
having
	count(airport_code) > 1

-- 2. Были ли брони, по которым не совершались перелеты?
select
	distinct book_ref
from
	bookings.tickets
	left join bookings.bookings using (book_ref)
	right join bookings.ticket_flights using (ticket_no)
	left join bookings.flights using (flight_id)
where
	actual_arrival is null

-- В каких аэропортах есть рейсы, которые обслуживаются самолетами с максимальной дальностью перелетов?
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
	left join bookings.airports using (airport_code)

-- Между какими городами пассажиры делали пересадки?
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
	ticket_no in (select ticket_no from transfer)
