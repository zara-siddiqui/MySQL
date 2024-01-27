USE sakila;
-- How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.name AS category, COUNT(fc.film_id) AS film_count
FROM sakila.category c
JOIN sakila.film_category fc
ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY film_count DESC;

-- Display the total amount rung up by each staff member in August of 2005.
SELECT c.staff_id, SUM(p.amount) AS total_amount
FROM sakila.staff c
JOIN sakila.payment p 
ON c.staff_id = p.staff_id
WHERE p.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY c.staff_id
ORDER BY total_amount;

-- Which actor has appeared in the most films?
SELECT a.first_name, a.last_name, COUNT(fc.film_id) AS film_count
FROM sakila.actor a
JOIN sakila.film_actor fc
ON a.actor_id = fc.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC;

-- Most active customer (the customer that has rented the most number of films)
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS rented_films 
FROM sakila.customer c
JOIN sakila.rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY rented_films DESC;

-- Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
ON s.address_id = a.address_id;

-- List each film and the number of actors who are listed for that film.
SELECT a.title, COUNT(ac.actor_id) AS no_of_actors
FROM sakila.film a
JOIN sakila.film_actor ac
ON a.film_id = ac.film_id
GROUP BY a.film_id, a.title
ORDER BY no_of_actors DESC;

-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT c.last_name, c.first_name, c.customer_id, SUM(p.amount) AS total_paid
FROM sakila.customer c
JOIN sakila.payment p
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name, c.first_name;

-- List the titles of films per category.
SELECT f.title, c.name AS category
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY category ASC, f.title;
