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
SELECT COUNT(inventory_id) FROM inventory

