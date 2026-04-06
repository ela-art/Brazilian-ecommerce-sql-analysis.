USE olist_db;

/* Validación y exploración inicial.
Este script se usa para revisar estructura, volumen de datos
y consistencia relacional antes del análisis. */

SHOW TABLES;

/* Confirmar cuántas filas tiene cada tabla */
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM category_translation;
SELECT COUNT(*) FROM sellers;
SELECT COUNT(*) FROM order_reviews;
SELECT COUNT(*) FROM order_payments;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM geolocation_zip;
SELECT COUNT(*) FROM products;

/* Primeras filas para revisar estructura y contenido */
SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_reviews LIMIT 5;
SELECT * FROM order_payments LIMIT 5;
SELECT * FROM order_items LIMIT 5;
SELECT * FROM sellers LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM category_translation LIMIT 5;
SELECT * FROM geolocation_zip LIMIT 5;

/* Validación básica de joins */
SELECT COUNT(*)
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT COUNT(*)
FROM orders o
JOIN order_items i ON o.order_id = i.order_id;

SELECT COUNT(*)
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id;

SELECT COUNT(*)
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id;

SELECT COUNT(*)
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

SELECT COUNT(*)
FROM geolocation_zip g
JOIN customers c ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix;