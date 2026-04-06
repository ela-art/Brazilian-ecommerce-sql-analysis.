USE olist_db;

/* What product categories generate the highest total revenue? */
CREATE OR REPLACE VIEW top_categories AS
SELECT ct.product_category_name_english, SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english;

SELECT * FROM top_categories ORDER BY total_revenue DESC LIMIT 10;

/* How does delivery delay relate to review scores by category? */
CREATE OR REPLACE VIEW category_reviews AS
SELECT 
  ct.product_category_name_english,
  AVG(r.review_score) AS avg_review,
  COUNT(*) AS total_reviews,
  CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
    ELSE 'on_time'
  END AS delivery_status
FROM order_reviews r
JOIN orders o ON r.order_id = o.order_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english, delivery_status
HAVING COUNT(*) >= 5;

SELECT * FROM category_reviews ORDER BY avg_review ASC LIMIT 20;

/* Overall relationship between delay and review score */
CREATE OR REPLACE VIEW review_scores AS 
SELECT 
  AVG(r.review_score) AS avg_review_score, 
  COUNT(*) AS total_scores, 
  CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'delayed'
    ELSE 'on_time'
  END AS delivery_status
FROM order_reviews r
JOIN orders o ON r.order_id = o.order_id
GROUP BY delivery_status;

SELECT * FROM review_scores ORDER BY total_scores ASC LIMIT 20;

/* Percentage of delayed orders by category */
CREATE OR REPLACE VIEW delivery_by_category AS
SELECT 
  ct.product_category_name_english,
  ROUND(AVG(CASE 
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
    ELSE 0
  END) * 100, 2) AS pct_delayed
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english;

SELECT * FROM delivery_by_category ORDER BY pct_delayed DESC LIMIT 20;
