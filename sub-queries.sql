-- SQL Subqueries
USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS No_of_copies
FROM sakila.inventory
WHERE film_id IN (
    SELECT film_id FROM sakila.film
    WHERE title = "Hunchback Impossible"
    GROUP BY title);

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM sakila.film
WHERE length > (SELECT AVG(length)
					FROM sakila.film)
ORDER BY length DESC;                    

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT actor_id, first_name, last_name
FROM sakila.actor
WHERE actor.actor_id IN ( 
						SELECT actor_id
						FROM sakila.film_actor
						WHERE film_actor.film_id IN (
													SELECT film_id
													FROM sakila.film
													WHERE film.title = "Alone Trip"));

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films;

SELECT title
FROM sakila.film f
WHERE f.film_id IN (
					  SELECT film_id
					  FROM sakila.film_category
					  WHERE category_id IN (
												SELECT category_id
												FROM sakila.category
												WHERE name = "family"
  )
);

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT first_name, last_name, email
FROM sakila.customer
WHERE address_id IN(
					SELECT address_id
                    FROM sakila.address
                    WHERE city_id IN(
									    SELECT city_id
                                        FROM sakila.city
                                        WHERE country_id IN(
																SELECT country_id
                                                                FROM sakila.country
                                                                WHERE country = "CANADA")));

 -- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
 -- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
 
 SELECT actor_id, COUNT(DISTINCT film_id) AS film_count
 FROM sakila.film_actor
 GROUP BY actor_id;
 
SELECT film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = (
								SELECT actor_id
								FROM film_actor
								GROUP BY actor_id
								ORDER BY COUNT(*) DESC
								LIMIT 1);
 
 
 

