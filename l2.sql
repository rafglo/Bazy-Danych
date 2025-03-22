-- 2.1
SELECT * FROM address 
WHERE 
    postal_code = ""
    OR address2 IS NULL;

SELECT MIN(postal_code), MAX(postal_code), COUNT(postal_code), SUM(postal_code), AVG(postal_code)
FROM address;

SELECT MIN(postal_code), MAX(postal_code), COUNT(postal_code), SUM(postal_code), AVG(postal_code)
FROM address WHERE postal_code != "";


-- 2.2
SELECT MIN(release_year), MAX(release_year) FROM film;
SELECT title FROM film
WHERE release_year = 2006;

-- 2.3
SELECT title FROM film
ORDER BY title DESC
LIMIT 9, 1;

-- 2.4
SELECT COUNT(film_id) 
FROM film
WHERE (description LIKE '% SUMO %' 
       OR description LIKE 'SUMO %' 
       OR description LIKE '% SUMO' 
       OR description = 'SUMO')

SELECT COUNT(film_id) 
FROM film
WHERE (description LIKE '% SUMO %' 
       OR description LIKE 'SUMO %' 
       OR description LIKE '% SUMO' 
       OR description = 'SUMO')
  AND description NOT LIKE '%SUMO WRESTLER%';

-- 2.5
--Znaleźć liczbę filmów, w których opisie pada słowo SUMO, 
--w tytule nie ma litery A oraz film_id jest większy niż
--długość filmu
SELECT COUNT(film_id) FROM film
WHERE description LIKE '%SUMO%'
AND title NOT LIKE '%A%'
AND film_id > length;

-- 2.6
-- Sprawdzić, w jakich filmach występuje pies (dog) w opisie filmu 
--oraz wilki (wolves) w tytule. Dla takiego filmu
--wyświetlić tabelę z id aktorów, którzy grali w filmie, 
--a następnie wyświetlić tabelę z imionami i nazwiskami tych
--aktorów.

SELECT film_id FROM film
WHERE description LIKE '% dog %'
AND title LIKE '%wolves%';

SELECT actor_id FROM film_actor
WHERE film_id = 316;

SELECT first_name, last_name FROM actor
WHERE actor_id = 5 OR actor_id = 58 OR actor_id = 82 OR actor_id = 117 
OR actor_id = 143;

--2.7
SELECT MIN(CAST(phone AS INTEGER)), MAX(CAST(phone AS INTEGER)) FROM address
WHERE phone IS NOT NULL AND phone != '';

--2.8
/*Zapoznać się z systemem oceny filmów Motion Picture Association (w internecie). 
A następnie wyświetlić tabelę
z tytułami filmów, która odpowie na pytanie klientki wypożyczalni: 
“Chciałabym wypożyczyć, dla 12-letniego
syna film. Interesuje się psami i kotami, więc chciałabym, 
aby w opisie filmu było coś o tych zwierzętach. Pozwolę
mu obejrzeć ten film samodzielnie, gdy nas nie będzie w domu”.*/

SELECT title FROM film
WHERE (rating LIKE 'PG' or rating LIKE 'G' OR rating LIKE 'PG-13')
AND (description LIKE '%dog%' OR description LIKE '%cat%');


--2.9
/* Klientka po uzyskaniu odpowiedzi stwierdziła również: 
“Chciałabym, aby film był jak najdłuższy oraz aby nie
posiadał usuniętych scen. Uważam, że wtedy film jest jakościowo najlepszy”. 
Znajdźmy tytuł filmu, który to
spełnia. */

SELECT title, film_id FROM film
WHERE (rating LIKE 'PG' or rating LIKE 'G' OR rating LIKE 'PG-13')
AND (description LIKE '%dog%' OR description LIKE '%cat%')
AND special_features NOT LIKE '%Deleted Scenes%'
ORDER BY length DESC 
LIMIT 1;

--2.10
-- Znaleźć ile sztuk tego filmu jest dostępnych i w których naszych placówkach.
SELECT COUNT(inventory_id), store_id FROM inventory
WHERE film_id = 182;

SELECT store_id FROM inventory
WHERE film_id = 182;

SELECT address_id FROM store
WHERE store_id = 1;

SELECT address FROM address
WHERE address_id = 1;

--2.11
/* Odnaleźć dane (imię i nazwisko) klientów, 
którzy wypożyczyli ten film i sprawdzić czy go oddali.
 */

SELECT inventory_id FROM inventory
WHERE film_id = 182;

SELECT customer_id FROM rental
WHERE inventory_id IN (832, 833);

SELECT first_name, last_name FROM customer
WHERE customer_id IN (470, 337, 430, 256, 325, 102, 259);

--2.12
/* Sprawdzić czy są nadal aktywnymi klientami.*/

SELECT active FROM customer
WHERE customer_id IN (470, 337, 430, 256, 325, 102, 259);

-- wszyscy są aktywni

--2.13
SELECT address_id FROM customer
WHERE customer_id IN (470, 337, 430, 256, 325, 102, 259);

SELECT phone FROM address
WHERE address_id IN (106, 261, 264, 330, 342, 435, 475);

--2.14
/* 
Która aktorka o imieniu PENELOPE 
zagrała w największej liczbie filmów dostępnych w naszej bazie danych?
*/

SELECT actor_id FROM actor
WHERE first_name LIKE 'PENELOPE';

SELECT actor_id, COUNT(film_id) AS film_counter FROM film_actor
WHERE actor_id IN (1, 54, 104, 120)
GROUP BY actor_id
ORDER BY film_counter DESC
LIMIT 1;

SELECT first_name, last_name FROM actor
WHERE actor_id = 104;

--2.15
/* 
Mamy tylko dwóch pracowników. 
Opierając się wyłącznie na wartości wypożyczeń (amount) określ, 
który z nich
zarobił więcej dla firmy.
*/

SELECT staff_id, SUM(amount) as suma FROM payment
GROUP BY staff_id
ORDER BY suma DESC
LIMIT 1;

SELECT first_name, last_name FROM staff
WHERE staff_id = 2;

--2.16
/*
Sprawdź czy podobny wynik będzie, 
gdy ograniczymy się do wakacji 2005 (od 1 lipca do 31 sierpnia).
*/

SELECT staff_id, SUM(amount) as suma FROM payment
WHERE payment_date BETWEEN '2005-07-01 00:00:00' 
                     AND '2005-08-31 23:59:59'
GROUP BY staff_id
ORDER BY suma DESC
LIMIT 1;

SELECT first_name, last_name FROM staff
WHERE staff_id = 2;

--2.17
/*
Sprawdzić ilu klientów ma email poza naszą domeną 
(sakilacustomer.org) i jakie to domeny.
*/

SELECT COUNT(customer_id) FROM customer
WHERE email NOT LIKE '%sakilacustomer.org';

--2.18
/*
Sprawdzić ilu aktywnych klientów 
ma nasza placówka o numerze 1, a ilu nasza druga placówka.
*/

SELECT store_id, COUNT(customer_id) FROM customer
WHERE active = 1
GROUP BY store_id; 

--2.19
/*
Sprawdzić ile płyt nie zostało jeszcze zwróconych, 
które wypożyczył pracownik numer 1, a ile w przypadku
pracownika numer 2. Zastanowić się czy 
jesteśmy w stanie sprawdzić te informacje dla naszych placówek.
*/

SELECT staff_id, COUNT(rental_id) FROM rental
WHERE return_date IS NULL OR return_date = ''
GROUP BY staff_id;

SELECT store_id, staff_id FROM staff;

-- W sklepie 1 pracuje tylko pracownik 1, a w sklepie 2 tylko 2,
-- więc możemy to powiązać

--2.20
/* 
Określić datę najdłuższego, niezwróconego jeszcze 
wypożyczenia i znaleźć numer telefonu do klienta, który
przetrzymuje ten film.
*/
SELECT customer_id FROM rental
WHERE return_date IS NULL OR return_date = ''
ORDER BY rental_date
LIMIT 1;

SELECT address_id FROM customer
WHERE customer_id = 554;

SELECT phone FROM address 
WHERE address_id = 560;
