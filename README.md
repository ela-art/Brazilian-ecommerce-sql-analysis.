# Brazilian E-commerce SQL Analysis (Olist)

## Project Overview
SQL-based analysis of the Brazilian e-commerce dataset (Olist) to extract insights on sales performance, customer behavior, and operational efficiency.

## Dataset
The dataset comes from Olist and includes orders, customers, products, sellers, payments, reviews, and geolocation.

⚠️ Raw data is not included in this repository due to size constraints.

To run this project, place the CSV files in:

## Objectives
Answer key business questions using SQL, focusing on data modeling, joins, aggregations, and analytical reasoning.

## Key Business Questions
- What product categories generate the highest total revenue?
- Which factors are associated with lower customer reviews (e.g., delays, sellers, categories)?
- How do sales, number of orders, and average ticket vary by customer location?
- Which sellers combine high sales volume with strong customer satisfaction?

## Project Structure
- `data/raw/` → local CSV files (not tracked)
- `sql/` → SQL scripts (setup, preparation, analysis)
- `01_carga_datos.ipynb` → data loading to database

## Tech Stack
- SQL
- Python (Pandas, SQLAlchemy)
- Jupyter Notebook

## Next Steps
Start with revenue analysis by product category and progressively address all business questions.