USE sakila;

SELECT customer_id, COUNT(*) as Ilość_Płatności, SUM(amount) as Wartość_Płatności from payment
GROUP BY customer_id
ORDER BY Wartość_Płatności DESC
LIMIT 5
OFFSET 5;

