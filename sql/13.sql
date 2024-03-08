/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
SELECT * FROM (
	SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title,
	       RANK() OVER(PARTITION BY a.actor_id ORDER BY sum(p.amount) DESC, f.title) as "rank",
	       sum(p.amount) as revenue
	FROM payment p
	JOIN rental r USING (rental_id)
	JOIN inventory i USING (inventory_id)
	JOIN film f USING (film_id)
	JOIN film_actor fa USING (film_id)
	JOIN actor a USING (actor_id)
	GROUP BY a.actor_id, f.film_id
) as t
WHERE "rank" < 4;
