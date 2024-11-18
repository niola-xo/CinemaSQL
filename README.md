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
