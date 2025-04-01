--4.1
SELECT GROUP_CONCAT(last_name ORDER BY last_name SEPARATOR ', ') AS 'Aktorzy o dwuliterowych imionach' FROM actor 
WHERE LENGTH(first_name) = 2;

--4.2 
SELECT film_id, title, CONCAT(
    LEFT(description, LOCATE('A', description) - 1), 
    SUBSTRING(description, LOCATE('A', description) + 1)) 
    AS new_description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features,last_update FROM film
WHERE '%BORING%' NOT LIKE description
ORDER BY new_description;

--4.3
SELECT customer_id, IF((rental_date BETWEEN '2005-07-01' AND '2005-08-31') AND (return_date>'2005-08-31'), 
CONCAT(COUNT(customer_id) * 0.5,'$') '0$') AS doplata FROM rental
GROUP BY customer_id;

SELECT 
    customer_id, 
    CONCAT(COUNT(*) * 0.5, '$') AS doplata 
    FROM rental
    WHERE (rental_date BETWEEN '2005-07-01' AND '2005-08-31 23:59:59') 
    AND (return_date > '2005-08-31 23:59:59')
GROUP BY customer_id
ORDER BY doplata DESC;

--4.4
SELECT city_id, 
       GROUP_CONCAT(DISTINCT district ORDER BY district SEPARATOR ' oraz ') AS dystrykty
FROM address
GROUP BY city_id
HAVING COUNT(DISTINCT district) > 1
ORDER BY city_id DESC;

--4.5
SELECT amount AS kwota_wypozyczenia, 
       staff_id AS pracownik, 
       SUM(amount) AS zarobek
FROM payment
GROUP BY amount, staff_id
ORDER BY zarobek DESC;

--4.6
SELECT MIN(IF(return_date IS NULL, 0, TIMESTAMPDIFF(SECOND, rental_date, return_date))) AS najkrotsze, 
MAX(IF(return_date IS NULL,TIMESTAMPDIFF(SECOND, rental_date, '2005-09-02 02:35:22') , TIMESTAMPDIFF(SECOND, rental_date, return_date))) AS najdluzsze
FROM rental
WHERE return_date IS NOT NULL;

--4.7
SELECT customer_id, 
AVG(IF(return_date IS NULL,TIMESTAMPDIFF(SECOND, rental_date, '2005-09-02 02:35:22') , TIMESTAMPDIFF(SECOND, rental_date, return_date))) / 86400 AS sredni_czas_dni
FROM rental
GROUP BY customer_id
ORDER BY sredni_czas DESC
LIMIT 1;

--4.8
SELECT customer_id, 
SUM(IF(return_date IS NULL,TIMESTAMPDIFF(SECOND, rental_date, '2005-09-02 02:35:22') , TIMESTAMPDIFF(SECOND, rental_date, return_date)) / 2629800) AS w_sumie_miesiecy
FROM rental
GROUP BY customer_id
ORDER BY w_sumie DESC
LIMIT 1;