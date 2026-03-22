USE olist_db;

CREATE TABLE geolocation_clean AS
SELECT geolocation_zip_code_prefix, AVG(geolocation_lat) AS geolocation_lat, AVG(geolocation_lng) AS geolocation_lng
FROM olist_geolocation_dataset
GROUP BY geolocation_zip_code_prefix;

