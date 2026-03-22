USE olist_db;
SHOW TABLES;

SELECT COUNT(*) FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_customers_dataset;
SELECT COUNT(*) FROM product_category_name_translation; 
SELECT COUNT(*) FROM olist_sellers_dataset; 
SELECT COUNT(*) FROM olist_order_reviews_dataset; 
SELECT COUNT(*) FROM olist_order_payments_dataset;
SELECT COUNT(*) FROM olist_order_items_dataset;
SELECT COUNT(*) FROM olist_geolocation_dataset;
SELECT COUNT(*) FROM olist_products_dataset;


SELECT * FROM olist_customers_dataset LIMIT 5;
SELECT * FROM olist_orders_dataset LIMIT 5;
SELECT * FROM olist_order_reviews_dataset LIMIT 5;
SELECT * FROM olist_order_payments_dataset LIMIT 5;
SELECT * FROM olist_order_items_dataset LIMIT 5;
SELECT * FROM olist_sellers_dataset LIMIT 5;
SELECT * FROM olist_products_dataset LIMIT 5;
SELECT * FROM product_category_name_translation LIMIT 5;
SELECT * FROM olist_geolocation_dataset LIMIT 5;

SELECT COUNT(*)
FROM olist_orders_dataset o
JOIN olist_customers_dataset c 
ON o.customer_id = c.customer_id;

SELECT COUNT(*)
FROM olist_orders_dataset o
JOIN olist_order_items_dataset i 
ON o.order_id = i.order_id;

SELECT COUNT(*)
FROM olist_orders_dataset o
JOIN  olist_order_reviews_dataset r
ON o.order_id = r.order_id;

SELECT geolocation_zip_code_prefix, AVG(geolocation_lat) AS geolocation_lat, AVG(geolocation_lng) AS geolocation_lng
FROM olist_geolocation_dataset
GROUP BY geolocation_zip_code_prefix;

SELECT COUNT(*)
FROM olist_orders_dataset o
JOIN  olist_order_payments_dataset p
ON o.order_id = p.order_id;

SELECT COUNT(*)
FROM olist_order_items_dataset oi
JOIN olist_products_dataset pd
ON oi.product_id = pd.product_id;

CREATE TABLE geolocation_clean AS
SELECT geolocation_zip_code_prefix, AVG(geolocation_lat) AS geolocation_lat, AVG(geolocation_lng) AS geolocation_lng
FROM olist_geolocation_dataset
GROUP BY geolocation_zip_code_prefix;

SELECT COUNT(*)
FROM geolocation_clean g
JOIN olist_customers_dataset c
ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix;