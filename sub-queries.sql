-- SQL Subqueries
USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT * FROM (
  SELECT film_id, title, COUNT(inventory_id) AS No_of_copies
  FROM sakila.film
  GROUP BY title
) sub1
WHERE title = "Hunchback Impossible";

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM sakila.film
WHERE length > (SELECT AVG(length)
					FROM sakila.film)
ORDER BY length DESC;                    

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT title
FROM sakila.film
WHERE film = "Alone Trip" (SELECT first_name, last_name
							FROM sakila.actor)
GROUP BY film;                            

