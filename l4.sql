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
GROUP_CONCAT(district ORDER BY district SEPARATOR ' ORAZ ')
WHERE 
