/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */
SELECT DISTINCT first_name || ' ' || last_name as "Actor Name" from film
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE film_id IN (
	SELECT film_id from film
	JOIN film_actor USING (film_id)
	JOIN actor USING (actor_id)
	WHERE first_name || ' ' || last_name ILIKE 'Russell Bacall'
) AND first_name || ' ' || last_name NOT ILIKE 'Russell Bacall'
ORDER BY first_name || ' ' || last_name;
