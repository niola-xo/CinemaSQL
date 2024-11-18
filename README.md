# Movie Database Management and Analytics

This project demonstrates advanced SQL queries for managing and analyzing data in a movie rental database. The queries cover a variety of operations, including aggregations, data retrieval, creating views, updating records, and deleting data based on conditions.

Table of Contents
Project Overview
Features
Setup
Queries Overview
How to Use
Acknowledgments
Project Overview
This project provides SQL scripts to:

Extract insights about movies, languages, and rental trends.
Perform data updates to reflect business policies.
Manage database views for better readability and analysis.
Delete obsolete or unnecessary data to keep the database clean and efficient.
The dataset focuses on movies, actors, rental details, languages, and financial transactions.

Features
Language-Specific Film Analysis: Identify 'G'-rated movies released in 2010 grouped by language.
Revenue Analysis: Calculate monthly revenue generated from movie rentals.
View Creation: Create a view summarizing table names and their columns for quick reference.
Popular Movies Analysis: Determine the most rented movies.
Data Updates: Adjust rental rates for specific actors’ movies.
Data Deletion: Remove high-cost or restricted-rated movies to streamline inventory.
Setup
Clone this repository:
bash
Copy code
git clone https://github.com/yourusername/movie-database-management.git  
Import your database into a PostgreSQL server. Ensure tables such as film, actor, language, inventory, and payment exist.
Run the provided SQL queries using any SQL client (e.g., pgAdmin, DBeaver, or psql).
Queries Overview
1. Aggregating Films by Language
Purpose: List 'G'-rated films from 2010 grouped by their language.
Query:
sql
Copy code
SELECT name,  
       STRING_AGG(title, ',') AS film_titles  
FROM film f  
INNER JOIN language l  
ON f.language_id = l.language_id  
WHERE release_year = '2010'  
AND rating = 'G'  
GROUP BY name;  
2. Monthly Revenue Analysis
Purpose: Summarize total revenue by month.
Query:
sql
Copy code
SELECT EXTRACT(MONTH FROM payment_date) AS month,  
       SUM(amount) AS total_payment  
FROM payment  
GROUP BY month  
ORDER BY month;  
3. Creating and Querying Views
Purpose: Create a view to display table names and their columns.

Query to Create View:

sql
Copy code
CREATE VIEW table_columns AS  
SELECT table_name,  
       STRING_AGG(column_name, ', ') AS columns  
FROM information_schema.columns  
WHERE table_schema = 'public'  
GROUP BY table_name;  
Query to Use View:

sql
Copy code
SELECT * FROM table_columns;  
4. Popular Movies Analysis
Purpose: Find the most rented movies and their rental count.
Query:
sql
Copy code
SELECT title, COUNT(title)  
FROM film AS f  
INNER JOIN inventory AS i  
ON f.film_id = i.film_id  
INNER JOIN rental AS r  
ON i.inventory_id = r.inventory_id  
GROUP BY title  
ORDER BY COUNT DESC;  
5. Rental Rate Update
Purpose: Reduce the rental rate for movies featuring specific actors.
Query:
sql
Copy code
UPDATE film  
SET rental_rate = rental_rate - 1  
WHERE film_id IN (  
    SELECT film_id  
    FROM actor AS a  
    INNER JOIN film_actor AS f  
    ON a.actor_id = f.actor_id  
    WHERE last_name IN ('WILLIS', 'CHASE', 'WINSLET', 'GUINESS', 'HUDSON')  
);  
6. Data Deletion
Purpose: Remove unwanted movies based on cost and rating.
Queries:
Delete high-cost movies:

sql
Copy code
DELETE FROM film  
WHERE replacement_cost > 25;  
Delete restricted-rated movies from inventory:

sql
Copy code
DELETE FROM inventory  
WHERE film_id IN (  
    SELECT film_id FROM film  
    WHERE rating IN ('R', 'NC-17')  
);  
Delete restricted-rated movies from the film table:

sql
Copy code
DELETE FROM film  
WHERE rating IN ('R', 'NC-17');  
How to Use
Execute the queries in sequence or modify them based on your requirements.
Analyze the results to make business decisions or manage the database efficiently.
Acknowledgments
This project is based on a hypothetical movie rental database inspired by common SQL learning datasets. Special thanks to all contributors to open-source learning resources.
