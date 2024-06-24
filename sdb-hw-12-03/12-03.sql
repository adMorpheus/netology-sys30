SELECT DISTINCT district
FROM sakila.address
WHERE district LIKE 'K%a' AND 
district NOT LIKE '% %';

SELECT * 
FROM sakila.payment
WHERE payment_date BETWEEN '2005-06-15' AND '2005-06-18 23:59:59'
AND amount > 10.00; 

SELECT *
FROM sakila.rental
ORDER BY rental_date DESC 
LIMIT 5;

SELECT REPLACE(LOWER(first_name), 'll', 'pp'), LOWER(last_name), active 
FROM sakila.customer 
WHERE (first_name = 'Kelly' OR first_name = 'Willie')
AND  active = 1;