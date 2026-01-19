CREATE DATABASE chinook;
USE chinook;

-- PRIMARY KEY
CREATE TABLE artist (
    artist_id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- FOREIGN KEY
CREATE TABLE album (
    album_id INT PRIMARY KEY,
    title VARCHAR(255),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);


CREATE TABLE genre (
    genre_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Track (Most important table)
CREATE TABLE track (
    track_id INT PRIMARY KEY,
    name VARCHAR(255),
    album_id INT,
    genre_id INT,
    milliseconds INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- Customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    country VARCHAR(100)
);

-- Invoice
CREATE TABLE invoice (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_date DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Invoice Line (Sales Table)
CREATE TABLE invoice_line (
    invoice_line_id INT PRIMARY KEY,
    invoice_id INT,
    track_id INT,
    unit_price DECIMAL(10,2),
    quantity INT,
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
    FOREIGN KEY (track_id) REFERENCES track(track_id)
);


SELECT COUNT(*) FROM track;
SELECT COUNT(*) FROM invoice;
SELECT COUNT(*) FROM invoice_line;

SELECT * FROM track LIMIT 10;
SELECT name, unit_price FROM track;

-- Filtering & Sorting (WHERE + ORDER BY)
SELECT t.name, g.name AS genre, t.unit_price
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
ORDER BY t.unit_price DESC;

-- Filtering & Sorting (WHERE + ORDER BY)
SELECT g.name AS genre,
       SUM(il.unit_price * il.quantity) AS total_sales
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- Average Track Price by Genre
SELECT g.name, AVG(t.unit_price) AS avg_price
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- HAVING Clause
SELECT g.name AS genre,
       SUM(il.unit_price * il.quantity) AS total_sales
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
HAVING SUM(il.unit_price * il.quantity) > 100000;

-- BETWEEN & LIKE (Monthly Sales)
SELECT invoice_date, total
FROM invoice
WHERE invoice_date BETWEEN '2013-01-01' AND '2013-01-31';

-- Customer Name Search
SELECT * FROM customer
WHERE first_name LIKE 'A%';

-- Top Customers
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Subquery
SELECT name FROM track
WHERE unit_price > (SELECT AVG(unit_price) FROM track);

-- Join Heavy Analysis
SELECT c.country, SUM(i.total) AS revenue
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country;

-- Indexing
CREATE INDEX idx_invoice_date ON invoice(invoice_date);

SELECT * FROM ARTIST;
desc artist;


