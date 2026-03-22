
USE olist_db;

DESCRIBE olist_orders_dataset;
DESCRIBE olist_customers_dataset;
DESCRIBE olist_order_reviews_dataset;
DESCRIBE olist_order_payments_dataset;
DESCRIBE olist_order_items_dataset;
DESCRIBE olist_products_dataset;
DESCRIBE olist_sellers_dataset;
DESCRIBE product_category_name_translation;
DESCRIBE olist_geolocation_dataset;


/*-- Q1. ¿Qué categorías de producto generan más ingresos totales?*/

CREATE VIEW top_categories AS
SELECT pcn.product_category_name_english, SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset oi 
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON pcn.product_category_name = p.product_category_name
GROUP BY pcn.product_category_name_english
ORDER by total_revenue DESC;

SELECT * FROM top_categories ORDER BY total_revenue DESC LIMIT 10;


/*¿Qué categorías, vendedores o condiciones de entrega se asocian con peores reviews?*/

CREATE VIEW o.olist_orders_dataset AS SELECT o.order_id,o.order_delivered_customer_date, (delivered > estimated) AS retraso FROM orders;

CREATE VIEW worst_reviews AS
SELECT pcn.product_category_name_english,s.seller_id, 
FROM olist_order_items_dataset oi 
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON pcn.product_category_name = p.product_category_name
GROUP BY pcn.product_category_name_english
ORDER by total_revenue DESC;





-- Q2. 
-- Q3. ¿Cómo varían ventas, número de pedidos y ticket medio según estado o región del cliente?
-- Q4. ¿Qué vendedores combinan mayor volumen de ventas con mejores valoraciones?*/
