USE olist_db;

/*validación y exploración inicial.
Usé este script para revisar estructura, 
volumen de datos y consistencia relacional antes de construir las views analíticas*/

SHOW TABLES;
/*Confirmar cuantas filas tiene cada tabla*/
SELECT COUNT(*) FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_customers_dataset;
SELECT COUNT(*) FROM product_category_name_translation; 
SELECT COUNT(*) FROM olist_sellers_dataset; 
SELECT COUNT(*) FROM olist_order_reviews_dataset; 
SELECT COUNT(*) FROM olist_order_payments_dataset;
SELECT COUNT(*) FROM olist_order_items_dataset;
SELECT COUNT(*) FROM olist_geolocation_dataset;
SELECT COUNT(*) FROM olist_products_dataset;

/*primeras 5 filas de cada tabla. Eso te permite ver columnas, tipos de contenido y 
entender qué representa cada tabla.*/

SELECT * FROM olist_customers_dataset LIMIT 5;
SELECT * FROM olist_orders_dataset LIMIT 5;
SELECT * FROM olist_order_reviews_dataset LIMIT 5;
SELECT * FROM olist_order_payments_dataset LIMIT 5;
SELECT * FROM olist_order_items_dataset LIMIT 5;
SELECT * FROM olist_sellers_dataset LIMIT 5;
SELECT * FROM olist_products_dataset LIMIT 5;
SELECT * FROM product_category_name_translation LIMIT 5;
SELECT * FROM olist_geolocation_dataset LIMIT 5;

/*los joins a partir de las claves compartidas y del nivel de detalle de cada tabla, 
validando después con counts que la relación tuviera sentido.*/

/*orders → se une con customers por customer_id
orders → se une con order_items por order_id
y desde order_items sigues:
order_items → products por product_id
order_items → sellers por seller_id
products → product_category_name_translation por product_category_name

Y aparte:
orders → payments por order_id
orders → reviews por order_id
customers o sellers → geolocation por zip_code_prefix*/


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