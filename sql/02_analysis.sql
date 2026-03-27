
USE olist_db;

-- What product categories generate the highest total revenue?
-- What is the relationship between delivery delay and review scores overall?
-- How does delivery delay impact customer reviews across product categories?
-- How do delivery delays vary across product categories?


CREATE OR REPLACE VIEW top_categories AS
SELECT pcn.product_category_name_english, SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON pcn.product_category_name = p.product_category_name
GROUP BY pcn.product_category_name_english;

SELECT * FROM top_categories ORDER BY total_revenue DESC LIMIT 10; 


CREATE OR REPLACE VIEW category_reviews AS
SELECT 
  pcn.product_category_name_english,
  AVG(r.review_score) AS avg_review,
  COUNT(*) AS total_reviews,
  CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
    ELSE 'on_time'
  END AS delivery_status
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON p.product_category_name = pcn.product_category_name
GROUP BY pcn.product_category_name_english, delivery_status
HAVING COUNT(*) >= 5;

SELECT * FROM category_reviews ORDER BY avg_review ASC LIMIT 20;


CREATE OR REPLACE VIEW review_scores AS SELECT AVG(r.review_score), COUNT(*) AS total_scores, CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
    ELSE 'on_time' END AS delivery_status
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
GROUP BY delivery_status;

SELECT * FROM review_scores ORDER BY total_scores ASC LIMIT 20;

SHOW TABLES;
DESC category_reviews;
DESC olist_customers_dataset;
DESC olist_geolocation_dataset;
DESC olist_order_items_dataset;
DESC olist_order_payments_dataset;
DESC olist_order_reviews_dataset;
DESC olist_orders_dataset;
DESC olist_products_dataset;
DESC olist_sellers_dataset;
DESC product_category_name_translation;
DESC review_scores;
DESC top_categories;
DESC v_seller_reviews;
DESC v_top_categories;
DESC worst_reviews;

CREATE OR REPLACE VIEW delivery_by_category AS
SELECT p.product_category_name,pcn.product_category_name_english,
 CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
    ELSE 'on_time' END AS delivery_status, COUNT(*) AS total_orders
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    JOIN olist_products_dataset p ON oi.product_id = p.product_id
    JOIN product_category_name_translation pcn ON p.product_category_name = pcn.product_category_name
    GROUP BY p.product_category_name,pcn.product_category_name_english, delivery_status;
    
    SELECT * FROM delivery_by_category ORDER BY product_category_name_english, total_orders DESC;
    
    