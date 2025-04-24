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
SELECT 
    staff.staff_id AS id_pracownika, 
    staff.store_id AS id_sklepu, 
    staff.first_name,
    staff.last_name,
    COUNT(*) AS ile_wypozyczen
FROM
    staff
JOIN
    rental
ON
    staff.staff_id = rental.staff_id
GROUP BY id_pracownika, id_sklepu;

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
SELECT 
    customer.first_name,
    customer.last_name,
    customer.email,
    address.phone,
    CONCAT(address.address, ', ', city.city, ', ', country.country) AS 'adres',
    CONCAT(staff.first_name, ' ', staff.last_name) AS 'manager'
FROM 
    customer
INNER JOIN
    address
ON 
    customer.address_id = address.address_id
INNER JOIN
    city
ON
    address.city_id = city.city_id
INNER JOIN
    country
ON
    city.country_id = country.country_id
INNER JOIN
    staff
ON
    customer.store_id = staff.store_id
WHERE 
    customer.first_name = 'CAROLYN'
AND
    customer.last_name = 'PEREZ';

--7.9
SELECT
    rental.rental_date,
    film.title,
    rental.return_date,
    payment.amount,
    payment.payment_date
FROM
    rental
INNER JOIN
    inventory
ON
    rental.inventory_id = inventory.inventory_id
INNER JOIN
    film
ON
    inventory.film_id = film.film_id
INNER JOIN
    payment
ON
    rental.rental_id = payment.rental_id
INNER JOIN
    customer
ON
    rental.customer_id = customer.customer_id
WHERE 
    customer.first_name = 'CAROLYN'
AND
    customer.last_name = 'PEREZ';

--7.10
SELECT
    film.title AS film_title,
    store.store_id,
    COUNT(DISTINCT inventory.inventory_id) AS total_copies,
    customer.customer_id,
    CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    customer.active AS is_active_customer,
    address.phone,
    rental.rental_id,
    rental.rental_date,
    rental.return_date,
    CASE
        WHEN rental.return_date IS NULL THEN 'NOT RETURNED'
        ELSE 'RETURNED'
    END AS return_status
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
WHERE film.title = 'CONTROL ANTHEM'
GROUP BY
    film.title,
    store.store_id,
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    customer.active,
    address.phone,
    rental.rental_id,
    rental.rental_date,
    rental.return_date
ORDER BY rental.rental_date;

--7.11
SELECT
    actor.first_name,
    actor.last_name
FROM
    actor
JOIN
    film_actor
ON
    actor.actor_id = film_actor.actor_id
JOIN
    inventory
ON
    film_actor.film_id = inventory.film_id
JOIN
    rental
ON
    inventory.inventory_id = rental.inventory_id
WHERE rental.customer_id = (
    SELECT 
    customer.customer_id
FROM
    customer
JOIN
    payment
ON 
    customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 1
)
GROUP BY actor.actor_id
ORDER BY COUNT(*) DESC
LIMIT 1;


--7.12
SELECT
    city.city,
    store.store_id,
    SUM(payment.amount)
FROM
    city
JOIN
    address
ON
    address.city_id = city.city_id
JOIN
    customer
ON
    address.address_id = customer.address_id
JOIN
    payment
ON
    store.manager_staff_id = payment.staff_id
GROUP BY store.store_id;


