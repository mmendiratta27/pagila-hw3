/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */
SELECT country, sum(amount) as total_payments from customer
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
JOIN payment USING(customer_id)
GROUP BY country
ORDER BY sum(amount) desc, country;

