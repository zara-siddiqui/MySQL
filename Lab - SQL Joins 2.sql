USE sakila;

-- List the number of films per category.
SELECT DISTINCT c.name AS category, COUNT(fc.film_id) AS film_count
FROM sakila.category c
JOIN sakila.film_category fc
ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY film_count DESC;

-- Retrieve the store ID, city, and country for each store.
SELECT c.city, c2.country, s.store_id
FROM sakila.store s
JOIN sakila.address a ON s.address_id = a.address_id
JOIN sakila.city c  ON a.city_id = c.city_id
JOIN sakila.country c2 ON c.country_id = c2.country_id;

-- Calculate the total revenue generated by each store in dollars.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM sakila.store s
JOIN sakila.staff s2 ON s.store_id = s2.store_id
JOIN sakila.payment p ON s2.staff_id = p.staff_id
GROUP BY s.store_id;

-- Determine the average running time of films for each category.
SELECT DISTINCT c.name AS Category, AVG(f.length) AS Average_length
FROM sakila.category c
JOIN sakila.film_category fc ON c.category_id = fc.category_id
JOIN sakila.film f ON f.film_id = fc.film_id
GROUP BY Category 
ORDER BY Average_length DESC;

-- Identify the film categories with the longest average running time.
SELECT DISTINCT c.name AS Category, AVG(f.length) AS Average_length
FROM sakila.category c
JOIN sakila.film_category fc ON c.category_id = fc.category_id
JOIN sakila.film f ON f.film_id = fc.film_id
GROUP BY Category 
ORDER BY Average_length DESC
LIMIT 5;

-- Display the top 10 most frequently rented movies in descending order.
SELECT f.title AS Name, COUNT(r.rental_id)AS Rented
FROM sakila.inventory i 
JOIN sakila.rental r ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON f.film_id = i.film_id
GROUP BY Name
ORDER BY rented DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT f.title AS Name, COUNT(r.rental_id)AS Rented
FROM sakila.inventory i 
JOIN sakila.rental r ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON f.film_id = i.film_id
WHERE title = "Academy Dinosaur" AND i.store_id = 1;

-- Provide a list of all distinct film titles, along with their availability status in the inventory. 
-- Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, 
-- and this information can be obtained using a CASE statement combined with IFNULL."
SELECT DISTINCT(f.title) AS name,
	CASE
	WHEN i.inventory_id IS NULL
    THEN "NOT available"
    ELSE "Available"
	END AS Availability
FROM sakila.film f
LEFT JOIN sakila.inventory i ON i.film_id = f.film_id;

