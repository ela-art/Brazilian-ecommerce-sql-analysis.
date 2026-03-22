# Brazilian E-commerce SQL Analysis (Olist)

## Project Overview
This project analyzes the Brazilian E-commerce Public Dataset by Olist using SQL, Python, and Power BI. The goal is to explore sales performance, customer behavior, product category performance, and review patterns, turning raw relational data into business insights and clear visual analysis.

## Dataset
The analysis is based on the Olist dataset, which includes information about orders, customers, products, sellers, payments, reviews, and geolocation.

## Dataset Characteristics
- Approximately 100k orders
- Approximately 1M order items
- Multiple relational tables covering sales, customers, products, sellers, payments, reviews, and geolocation
- Time range: 2016–2018

Raw CSV files are stored locally and are not included in this repository.

To run this project, place the original files in:

`data/raw/`

## Objectives
The project aims to answer relevant business questions through SQL analysis, combining data extraction, joins, aggregations, and analytical reasoning.

Main objectives include:
- Identifying the product categories with the highest total revenue
- Exploring factors associated with lower customer review scores
- Comparing sales performance across locations
- Analyzing seller performance in terms of revenue and customer satisfaction

## Key Business Questions
- What product categories generate the highest total revenue?
- Which factors are associated with lower customer reviews, such as delays, sellers, or categories?
- How do sales, number of orders, and average ticket vary by customer location?
- Which sellers combine high sales volume with strong customer satisfaction?

## Project Structure
- `data/raw/` → original local CSV files (not tracked in the repository)
- `sql/` → SQL scripts for validation checks, analysis, and supporting queries
- `notebooks/` → Jupyter notebooks for data loading and preparation
- `dashboards/` → Power BI report files
- `README.md` → project documentation

## Tech Stack
- SQL
- Python
- Pandas
- SQLAlchemy
- Jupyter Notebook
- Power BI

## Workflow
The project follows these main stages:
1. Load raw CSV files into the database
2. Validate structure and data consistency
3. Write SQL queries to answer business questions
4. Export analytical outputs for visualization
5. Build a Power BI report based on the query results

## Notes
This project is structured as a portfolio piece focused on analytical thinking, SQL querying, and business-oriented data storytelling. It works with analytical outputs and aggregated views for reporting purposes.

## Next Steps
The next step is to continue expanding the SQL analysis and improve the Power BI report with clear visuals, concise business insights, and consistent project documentation.
