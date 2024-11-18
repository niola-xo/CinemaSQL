-- Preparing 'G'rated moviess released in 2010 according to language
SELECT name, 
		STRING_AGG(title, ',') film_titles
FROM film f
INNER JOIN language l
ON f.language_id = l.language_id
WHERE release_year = '2010'
AND rating = 'G'
GROUP BY name

SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname = 'public'


-- Finding out how much the business makes per month
SELECT  EXTRACT(MONTH FROM payment_date) as month,
		SUM(amount) as total_payment
FROM payment
GROUP BY month
ORDER BY month


SELECT name, 
		STRING_AGG(title, ',') film_titles
FROM film f
INNER JOIN language l
ON f.language_id = l.language_id
WHERE release_year = '2010'
AND rating = 'G'
GROUP BY name


-- Create a new view called table_columns
CREATE VIEW table_columns AS
SELECT table_name, 
	   STRING_AGG(column_name, ', ') AS columns
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name;

-- Query the newly created view table_columns
SELECT *
FROM table_columns;


SELECT title, COUNT(title)
FROM film AS f
INNER JOIN inventory AS i
  ON f.film_id = i.film_id
INNER JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY count DESC;


SELECT title, COUNT(title)
FROM film AS f
INNER JOIN inventory AS i
  ON f.film_id = i.film_id
INNER JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY count DESC;

-- Create a new table called oscars
CREATE TABLE oscars (
    title varchar,
    award varchar
);
SELECT *
FROM oscars
limit 20

-- Drecreasing the rental rate for films with specific actors
 UPDATE film
SET rental_rate = rental_rate - 1
WHERE film_id IN 
  (SELECT film_id from actor AS a
   INNER JOIN film_actor AS f
      ON a.actor_id = f.actor_id
   WHERE last_name IN ('WILLIS', 'CHASE', 'WINSLET', 'GUINESS', 'HUDSON'));


-- Delete films that cost most than 25 dollars
DELETE FROM film
WHERE replacement_cost > 25



-- Use the list of film_id values to DELETE all R & NC-17 rated films from inventory.
DELETE FROM inventory
WHERE film_id IN (
  SELECT film_id FROM film
  WHERE rating IN ('R', 'NC-17')
);

-- Delete records from the `film` table that are either rated as R or NC-17.
DELETE FROM film
WHERE rating IN ('R', 'NC-17');















