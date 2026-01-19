
-- Task 3 SQL Queries for Chinook Database

-- 1. Verify record counts
SELECT COUNT(*) AS total_tracks FROM track;
SELECT COUNT(*) AS total_customers FROM customer;
SELECT COUNT(*) AS total_invoices FROM invoice;

-- 2. Basic SELECT
SELECT * FROM track LIMIT 10;

-- 3. Filtering using WHERE and ORDER BY
SELECT name, unit_price
FROM track
WHERE unit_price > 0.99
ORDER BY unit_price DESC;

-- 4. Aggregation: Total Sales by Genre
SELECT g.name AS genre,
       SUM(il.unit_price * il.quantity) AS total_sales
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- 5. HAVING clause
SELECT g.name AS genre,
       SUM(il.unit_price * il.quantity) AS total_sales
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
HAVING SUM(il.unit_price * il.quantity) > 100000;

-- 6. BETWEEN for date range
SELECT invoice_id, invoice_date, total
FROM invoice
WHERE invoice_date BETWEEN '2013-01-01' AND '2013-12-31';

-- 7. LIKE for pattern search
SELECT * FROM customer
WHERE first_name LIKE 'A%';
