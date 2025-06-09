-- 8.1
CREATE TEMPORARY TABLE actor_276020 (
    actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    imię VARCHAR(45) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id)
);

INSERT INTO actor_276020 (actor_id, imię, nazwisko, last_update)
SELECT actor_id, first_name, last_name, last_update
FROM sakila.actor;

SELECT * FROM actor_276020;

-- 8.2
CREATE TEMPORARY TABLE film_276020 AS
SELECT * FROM sakila.film;

CREATE TEMPORARY TABLE film_actor_276020 AS
SELECT * FROM sakila.film_actor;

CREATE TEMPORARY TABLE category_276020 AS
SELECT * FROM sakila.category;

CREATE TEMPORARY TABLE film_category_276020 AS
SELECT * FROM sakila.film_category;

CREATE TEMPORARY TABLE customer_276020 AS
SELECT * FROM sakila.customer;

-- 8.3
INSERT INTO actor_276020 (imię, nazwisko) VALUES
('Ryszard', 'Kotys'),
('Andrzej', 'Grabowski'),
('Dariusz', 'Gnatowski');

--8.4
CREATE TEMPORARY TABLE fav_film_fans_276020 AS
SELECT DISTINCT
    customer.customer_id,
    customer.first_name,
    customer.last_name
FROM
    customer_276020 AS customer
JOIN
    sakila.rental 
ON 
    customer.customer_id = rental.customer_id
JOIN
    sakila.inventory
ON 
    rental.inventory_id = inventory.inventory_id
JOIN
    film_276020 AS film
ON 
    inventory.film_id = film.film_id
WHERE
    film.title = 'ACADEMY DINOSAUR';

SELECT * FROM fav_film_fans_276020;

-- 8.5
ALTER TABLE fav_film_fans_276020
ADD COLUMN film_fan_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

--8.6
UPDATE actor_276020
SET nazwisko = (
    SELECT nazwisko 
    FROM actor_276020 
    WHERE actor_id = 25
)
WHERE imię = "Sandra" AND nazwisko = "Kilmer";

--8.7
ALTER TABLE actor_276020
ADD COLUMN played_in_1 TINYINT(1) NOT NULL DEFAULT 0;

UPDATE actor_276020
SET played_in_1 = 
    CASE
        WHEN actor_id IN (
            SELECT actor_id 
            FROM film_actor_276020 
            WHERE film_id = 1
            ) 
            THEN 1
        ELSE 0
    END;

--8.8
CREATE TEMPORARY TABLE rental_valentine_276020 AS
SELECT *
FROM sakila.rental
WHERE DATE(rental_date) = '2006-02-14';

UPDATE rental_valentine_276020
JOIN 
    sakila.inventory
ON
    rental_valentine_276020.inventory_id = inventory.inventory_id
JOIN
    sakila.film
ON 
    inventory.film_id = film.film_id
SET return_date = NOW()
WHERE
    film.title = 'CREATURES SHAKESPEARE';

--8.9
UPDATE film_276020
SET rental_rate = FLOOR(rental_rate * 1.2) + 0.99;

SELECT rental_rate FROM film_276020;

--8.10
UPDATE customer_276020
SET active = 0
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM rental_valentine_276020
);

--8.11
DELETE FROM actor_276020
ORDER BY actor_id DESC
LIMIT 1;

SELECT * FROM actor_276020
ORDER BY actor_id DESC
LIMIT 3;

--8.12
DELETE film_276020
FROM film_276020
JOIN
    film_category_276020
ON 
    film_276020.film_id = film_category_276020.film_id
JOIN
    category_276020
ON
    film_category_276020.category_id = category_276020.category_id
WHERE
    category_276020.name = 'Drama';

--8.13
DELETE actor_276020
FROM
    actor_276020
LEFT JOIN
    film_actor_276020 
ON 
    actor_276020.actor_id = film_actor_276020.actor_id
WHERE
    film_actor_276020.actor_id IS NULL;

--8.14
DELETE actor_276020, film_actor_276020
FROM
    actor_276020
LEFT JOIN
    film_actor_276020
ON
    actor_276020.actor_id = film_actor_276020.actor_id
WHERE
    LEFT(actor_276020.imię,1) = LEFT(actor_276020.nazwisko, 1);


