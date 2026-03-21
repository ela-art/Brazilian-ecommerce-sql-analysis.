
USE olist_db;

-- Q1: What product categories generate the highest total revenue?

-- Q2: How does delivery delay impact customer reviews across product categories?

-- Q3: Which sellers receive the lowest reviews, and how is this influenced by delivery delays?

-- Q4: What is the relationship between delivery delay and review scores overall?


CREATE OR REPLACE VIEW v_top_categories AS
SELECT pcn.product_category_name_english, SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON pcn.product_category_name = p.product_category_name
GROUP BY pcn.product_category_name_english;


SELECT * FROM v_top_categories ORDER BY total_revenue DESC LIMIT 10; 



CREATE OR REPLACE VIEW v_category_reviews AS
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

SELECT * FROM v_category_reviews ORDER BY avg_review ASC LIMIT 20;



CREATE OR REPLACE VIEW v_seller_reviews AS
SELECT 
  s.seller_id,
  AVG(r.review_score) AS avg_review,
  COUNT(*) AS total_reviews,
  CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN  'delayed' 
    ELSE 'on_time'
  END AS delivery_status
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_sellers_dataset s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id, delivery_status;


SELECT * FROM v_seller_reviews ORDER BY avg_review ASC LIMIT 20;