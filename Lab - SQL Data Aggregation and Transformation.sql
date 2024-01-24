-- Challenge 1
USE sakila;
SELECT * FROM sakila.film;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT FLOOR(AVG(length)/60) AS time FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating.

SELECT datediff(MAX(rental_date), MIN(rental_date)) AS company_operating_days 
FROM rental; 

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
-- Return 20 rows of results.

SELECT *, DATE_FORMAT(CONVERT(LEFT(rental_date,10),DATE), '%M') AS 'rental_month',
DATE_FORMAT(CONVERT(LEFT(rental_date,10),DATE), '%W') AS 'rental_day' 
FROM sakila.rental LIMIT 20;

-- 3. retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.

SELECT title, IFNULL(rental_duration, 'Not Available') FROM sakila.film ORDER BY title ASC;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT concat(first_name,'  ', last_name) AS Names, left(email,3) AS Email_Address FROM sakila.customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1. Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(film_id) FROM film AS Total_films;

-- 1.2 The number of films for each rating.

SELECT rating, COUNT(*) AS Num_of_films FROM sakila.film 
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 

SELECT rating, COUNT(*) AS Num_of_films FROM sakila.film 
GROUP BY rating ORDER BY Num_of_films DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category. 

SELECT rating, ROUND(AVG(length),2) AS average_duration FROM sakila.film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours.
-- in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length),2) AS average_duration,
FLOOR(AVG(length)/60) AS average_duration_hours 
FROM sakila.film GROUP BY rating;

-- 3. Bonus: determine which last names are not repeated in the table actor.

SELECT last_name FROM actor GROUP BY last_name
HAVING COUNT(last_name) = 1;
