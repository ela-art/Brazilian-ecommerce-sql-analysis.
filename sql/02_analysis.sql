
USE olist_db;

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

-- What product categories generate the highest total revenue?

CREATE OR REPLACE VIEW top_categories AS
SELECT pcn.product_category_name_english, SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON pcn.product_category_name = p.product_category_name
GROUP BY pcn.product_category_name_english;

SELECT * FROM top_categories ORDER BY total_revenue DESC LIMIT 10; 


--- How does the relationship between delivery delay and review scores vary across product categories?

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


/*What is the relationship between delivery delays and review scores overall?*/

CREATE OR REPLACE VIEW review_scores AS 
SELECT AVG(r.review_score) AS avg_review_score, 
COUNT(*) AS total_scores, 
CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
    ELSE 'on_time' END AS delivery_status
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
GROUP BY delivery_status;

SELECT * FROM review_scores ORDER BY total_scores ASC LIMIT 20;


CREATE OR REPLACE VIEW delivery_by_category AS
SELECT 
  pcn.product_category_name_english,
  ROUND(AVG(CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
    ELSE 0
  END) * 100, 2) AS pct_delayed
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn ON p.product_category_name = pcn.product_category_name
GROUP BY pcn.product_category_name_english;

SELECT * FROM delivery_by_category ORDER BY pct_delayed DESC LIMIT 20;

