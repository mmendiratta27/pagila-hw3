/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH bac_1_id AS (
	SELECT film_id, actor_id  from film
	JOIN film_actor USING (film_id)
        JOIN actor USING (actor_id)
	WHERE actor_id in (
		SELECT DISTINCT actor_id from film
		JOIN film_actor USING (film_id)
		JOIN actor USING (actor_id)
		WHERE film_id IN (
			SELECT film_id from film
			JOIN film_actor USING (film_id)
			JOIN actor USING (actor_id)
			WHERE first_name || ' ' || last_name ILIKE 'Russell Bacall'
		)
	)	
)

SELECT DISTINCT first_name || ' ' || last_name as "Actor Name" from film
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE film_id in (SELECT film_id from bac_1_id)
	AND actor_id not in (select actor_id from bac_1_id)
ORDER BY first_name || ' ' || last_name;	
