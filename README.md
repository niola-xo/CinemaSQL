# DVD Rental Analysis - Database Project

## Project Overview

This project analyzes the operations of a DVD rental business using SQL queries to gain insights into key business metrics such as **payment trends**, **rental behavior**, and **film popularity**. The goal is to perform data analysis on the database to make informed business decisions based on the findings.

## Purpose

The purpose of this project is to generate business insights from a DVD rental database using various SQL queries. The queries explore different aspects of the rental business, including **payments**, **film rentals**, and **pricing strategies**.

---

## Queries and Results

### **1. Monthly Payment Analysis**
This query calculates the **total payments** made each month, helping understand the **financial trends** of the business.

```sql
SELECT EXTRACT(MONTH FROM payment_date) AS month,
       SUM(amount) AS total_payment
FROM payment
GROUP BY month
ORDER BY month;
```

### **1. Films by Language (2010 and G-rated)**
This query returns a list of G-rated films released in 2010, grouped by language.
 ```
SELECT name, 
       STRING_AGG(title, ',') AS film_titles
FROM film f
INNER JOIN language l
  ON f.language_id = l.language_id
WHERE release_year = '2010'
  AND rating = 'G'
GROUP BY name;

```
### **2. Films by Language (2010 and G-rated)**
This query returns a list of G-rated films released in 2010, grouped by language.

 ```
SELECT name, 
       STRING_AGG(title, ',') AS film_titles
FROM film f
INNER JOIN language l
  ON f.language_id = l.language_id
WHERE release_year = '2010'
  AND rating = 'G'
GROUP BY name;

```

### **3. Top Rented Films**
This query identifies the most rented films based on rental frequency, giving insight into the most popular films in the catalog
 ```
SELECT title, COUNT(title) 
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY COUNT(title) DESC;

```

### **4. Database Schema Overview**
This query provides a summary of all the tables in the database, helping understand the structure.
 ```
SELECT table_name, 
       STRING_AGG(column_name, ', ') AS columns
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name;

```

### **5. Rental Rate Adjustment for Specific Actors**
This query adjusts the rental rate for films featuring specific actors, demonstrating a business pricing strategy.
```
UPDATE film
SET rental_rate = rental_rate - 1
WHERE film_id IN 
  (SELECT film_id 
   FROM actor AS a
   INNER JOIN film_actor AS f ON a.actor_id = f.actor_id
   WHERE last_name IN ('WILLIS', 'CHASE', 'WINSLET', 'GUINESS', 'HUDSON'));

```

### **6. Top 5 Most Popular Films in Inventory**
This query counts the number of times each film title appears in the inventory, which shows the popularity and demand for the films.
```
UPDATE film
SET rental_rate = rental_rate - 1
WHERE film_id IN 
  (SELECT film_id 
   FROM actor AS a
   INNER JOIN film_actor AS f ON a.actor_id = f.actor_id
   WHERE last_name IN ('WILLIS', 'CHASE', 'WINSLET', 'GUINESS', 'HUDSON'));

```

### **7. Query to List Tables in the Database**
This query returns all the tables in the database, which helps in understanding the database structure.
```
SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname = 'public';

```

### **8. Deleting Films with High Replacement Costs**
This query deletes films with a replacement cost greater than 25, effectively removing high-cost films from the system.
```
DELETE FROM film
WHERE replacement_cost > 25;

```

### **9. Deleting R & NC-17 Rated Films from Inventory**
This query deletes films with R or NC-17 ratings from the inventory table.

```
DELETE FROM inventory
WHERE film_id IN (
  SELECT film_id FROM film
  WHERE rating IN ('R', 'NC-17')
);

```

### **10. Deleting R & NC-17 Rated Films from the Film Table**
This query deletes R and NC-17 rated films from the film table, likely to comply with business guidelines.
```
DELETE FROM film
WHERE rating IN ('R', 'NC-17');

```

## Conclusion
This project offers valuable insights into how SQL can be applied in business operations such as payment tracking, film rental analysis, and pricing strategies. The queries demonstrate how data analysis can assist in decision-making and improve business performance.
