# Bike Store SQL & Power BI Analysis

A practical Data Analytics portfolio project built using the BikeStores sample database in PostgreSQL and Power BI.

The project contains SQL queries designed to practice technical interview skills and solve realistic business problems, combined with an interactive Power BI dashboard for executive reporting and data visualization.

## Project Goals

* Analyze Bike Store sales data using SQL and Power BI
* Identify key sales trends, top-performing products, brands, categories, and stores
* Evaluate customer purchasing behavior and revenue performance
* Apply SQL techniques including joins, subqueries, CTEs, aggregations, and window functions to solve business-oriented analytical tasks
* Build an interactive Power BI dashboard to visualize sales KPIs and business performance
* Translate raw transactional data into actionable business insights
* Demonstrate practical Data Analyst skills through an end-to-end analytics project

## Key Business Insights

* **Baldwin Bikes** generated **$5.83M**, approximately **68% of total network revenue**.
* **Trek** led by revenue (**$5.13M**), while **Electra** led by units sold (**2,612 units**).
* **Mountain Bikes** generated the highest category revenue (**$3.03M**).
* **Cyclocross Bicycles** had the highest average revenue per product (**$79.9K**).
* **Pamelia Newman** was the top customer by revenue, generating **$37.8K**.
* Revenue peaked at **$909.2K in April 2018**, followed by an unusual drop; missing/low data in May–June 2018 should be investigated as a potential **data-quality issue**.

## Technologies & Tools

- **Database:** PostgreSQL
- **Database Client:** DBeaver
- **BI & Visualization:** Power BI Desktop
- **Version Control:** Git, GitHub

## Topics Covered

- ✅ Filtering & Sorting
- ✅ Aggregations
- ✅ JOINs & Advanced JOINs
- ✅ Subqueries
- ✅ Common Table Expressions (CTE)
- ✅ Window Functions
- ✅ Business Cases & Sales Analytics
- ✅ Interactive Dashboarding & Data Modeling (Power BI)

## Power BI Sales Dashboard

![Dashboard Preview](PowerBI/dashboard.png)

The interactive Power BI dashboard provides dynamic visual insights into overall sales performance, top-performing stores, revenue by category, and customer purchasing patterns. 

* The `.pbix` file is available in the [`powerbi/`](PowerBI/) folder.

## Project Structure

```text
bike-store-sql-analysis/
│
├── sql/
│   ├── 01_filtering_sorting.sql
│   ├── 02_aggregations.sql
│   ├── 03_joins.sql
│   ├── 04_joins_advanced.sql
│   ├── 05_subqueries.sql
│   ├── 06_cte.sql
│   ├── 07_window_functions.sql
│   └── 08_business_cases.sql
│
├── PowerBI/
│   └── bike_store_analysis.pbix
│
├── dashboard_preview.png
└── README.md
