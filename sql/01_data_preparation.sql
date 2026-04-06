USE olist_db;

DROP TABLE IF EXISTS geolocation_clean;

CREATE TABLE geolocation_clean AS
SELECT
    geolocation_zip_code_prefix,
    AVG(geolocation_lat) AS geolocation_lat,
    AVG(geolocation_lng) AS geolocation_lng
FROM geolocation_zip
GROUP BY geolocation_zip_code_prefix;