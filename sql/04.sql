/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT DISTINCT first_name, last_name from (
	SELECT first_name, last_name, name from film
	JOIN film_category USING(film_id)
	JOIN category USING(category_id)
	JOIN film_actor USING(film_id)
	JOIN actor USING(actor_id)
	WHERE name ilike 'Children'
) child
WHERE first_name || ' ' || last_name NOT IN (
	SELECT first_name || ' ' || last_name from film
        JOIN film_category USING(film_id)
        JOIN category USING(category_id)
        JOIN film_actor USING(film_id)
        JOIN actor USING(actor_id)
        WHERE name ilike 'Horror'
) ORDER BY last_name;
