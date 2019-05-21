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

-- 
