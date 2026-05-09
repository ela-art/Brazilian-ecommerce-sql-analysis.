USE olist_db;

/* Validacion y exploracion inicial.
   Este script revisa estructura, volumen de datos y consistencia
   relacional antes del analisis. */

SHOW TABLES;

/* Recuento de filas por tabla en una sola query */
SELECT 'orders'              AS tabla, COUNT(*) AS filas FROM orders
UNION ALL SELECT 'customers',          COUNT(*) FROM customers
UNION ALL SELECT 'order_items',        COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments',     COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews',      COUNT(*) FROM order_reviews
UNION ALL SELECT 'products',           COUNT(*) FROM products
UNION ALL SELECT 'sellers',            COUNT(*) FROM sellers
UNION ALL SELECT 'geolocation_zip',    COUNT(*) FROM geolocation_zip
UNION ALL SELECT 'category_translation', COUNT(*) FROM category_translation
ORDER BY tabla;

/* Primeras filas de cada tabla para revisar estructura */
SELECT * FROM customers          LIMIT 5;
SELECT * FROM orders             LIMIT 5;
SELECT * FROM order_items        LIMIT 5;
SELECT * FROM order_payments     LIMIT 5;
SELECT * FROM order_reviews      LIMIT 5;
SELECT * FROM products           LIMIT 5;
SELECT * FROM sellers            LIMIT 5;
SELECT * FROM category_translation LIMIT 5;
SELECT * FROM geolocation_zip    LIMIT 5;

/* Nulos en columnas clave */
SELECT
    SUM(CASE WHEN order_id     IS NULL THEN 1 ELSE 0 END) AS orders_sin_id,
    SUM(CASE WHEN customer_id  IS NULL THEN 1 ELSE 0 END) AS orders_sin_customer,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS orders_sin_status
FROM orders;

SELECT
    SUM(CASE WHEN order_id    IS NULL THEN 1 ELSE 0 END) AS items_sin_order_id,
    SUM(CASE WHEN product_id  IS NULL THEN 1 ELSE 0 END) AS items_sin_product_id,
    SUM(CASE WHEN price        IS NULL THEN 1 ELSE 0 END) AS items_sin_precio
FROM order_items;

SELECT
    SUM(CASE WHEN order_id      IS NULL THEN 1 ELSE 0 END) AS reviews_sin_order_id,
    SUM(CASE WHEN review_score  IS NULL THEN 1 ELSE 0 END) AS reviews_sin_score
FROM order_reviews;

/* Integridad referencial: registros huerfanos */
SELECT COUNT(*) AS orders_sin_cliente
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS items_sin_pedido
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS items_sin_producto
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS reviews_sin_pedido
FROM order_reviews r
LEFT JOIN orders o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

/* Validacion basica de joins (volumenes esperados) */
SELECT COUNT(*) AS orders_con_cliente
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT COUNT(*) AS lineas_con_pedido
FROM order_items i
JOIN orders o ON i.order_id = o.order_id;

SELECT COUNT(*) AS pagos_con_pedido
FROM order_payments p
JOIN orders o ON p.order_id = o.order_id;
