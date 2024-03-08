/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN LATERAL (
  SELECT *
  FROM rental r
  WHERE customer_id = c.customer_id
  ORDER BY rental_date desc
  LIMIT 5
) as rental ON TRUE
JOIN inventory USING (inventory_id)
JOIN film USING(film_id)
JOIN film_category USING(film_id)
WHERE category_id = 1
GROUP BY c.customer_id
HAVING count(c.customer_id) >=4
ORDER BY c.customer_id;
