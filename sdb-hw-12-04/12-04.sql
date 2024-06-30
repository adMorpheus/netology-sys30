
-- Алиасы короче, но, в данном случае, как-то неинформативно 's','s2', итд. 
SELECT CONCAT( staff.first_name, ' ', staff.last_name) as 'Staff name',   city.city, count(customer.customer_id) as 'Customer count'  
FROM staff
JOIN store on store.manager_staff_id = staff.staff_id 
JOIN address on address.address_id = store.address_id
JOIN city on city.city_id = address.city_id 
JOIN customer on customer.store_id  = store.store_id 
group by store.store_id
HAVING COUNT(customer.customer_id) > 300;


SELECT COUNT(*)
FROM film
WHERE `length` > (SELECT AVG(`length`) FROM film); 

SELECT DATE_FORMAT(payment_date, "%M - %Y") as month_name, COUNT(rental_id) as 'Count rentals' 
FROM payment
GROUP BY month_name 
ORDER BY SUM(amount) DESC 
LIMIT 1;


