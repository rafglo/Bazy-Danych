--7.1
SELECT 
    staff.first_name, 
    staff.last_name, 
    staff.email, 
    address.address, 
    address.phone
FROM 
    staff
INNER JOIN 
    address ON staff.address_id = address.address_id;

--7.2
SELECT 
    city.city,
    country.country
FROM
    city
INNER JOIN
    country ON city.country_id = country.country_id;

--7.3
SELECT 
    address.address,
    city.city,
    country.country
FROM    
    address
INNER JOIN
    city
ON
    address.city_id = city.city_id
INNER JOIN
    country
ON
    city.country_id = country.country_id;

--7.4
SELECT 
    staff.first_name, 
    staff.last_name, 
    staff.email, 
    address.address, 
    address.phone,
    city.city,
    country.country
FROM 
    staff
INNER JOIN 
    address 
ON staff.address_id = address.address_id
INNER JOIN
    city
ON
    address.city_id = city.city_id
INNER JOIN
    country
ON
    city.country_id = country.country_id;

--7.5
SELECT staff.store_id AS id_sklepu, staff.staff_id AS id_pracownika, COUNT(*) AS ile_wypozyczen
FROM
    staff
INNER JOIN
    rental
ON
    staff.staff_id = rental.staff_id
GROUP BY id_sklepu, id_pracownika

--7.6
SELECT 
    actor.first_name,
    actor.last_name,
    GROUP_CONCAT(film.title SEPARATOR ', ') AS 'Tytuły filmów'
FROM    
    actor
INNER JOIN
    film_actor
ON
    actor.actor_id = film_actor.actor_id
INNER JOIN
    film
ON
    film_actor.film_id = film.film_id
GROUP BY actor.actor_id;

--7.7
SELECT DISTINCT
    actor.first_name,
    actor.last_name
FROM    
    actor
INNER JOIN
    film_actor
ON
    actor.actor_id = film_actor.actor_id
INNER JOIN
    film
ON
    film_actor.film_id = film.film_id
WHERE film.title LIKE '%BLOOD%';

--7.8