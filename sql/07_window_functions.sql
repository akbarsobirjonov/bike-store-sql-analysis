-- ============================================================
-- 07_window_functions.sql
-- Window Functions Practice
-- BikeStores Database
-- ============================================================

-- ============================================================
-- Task 1: Product Price Ranking by Category
-- Rank products by price within each category.
-- Products with the same price receive the same rank.
-- ============================================================

select
	p.product_id,
	p.product_name,
	p.list_price,
	c.category_name,
	c.category_id,
	rank() over (
partition by c.category_id
order by
	p.list_price desc
) as price_rank
from
	products p
inner join categories c
on
	p.category_id = c.category_id;

-- ============================================================
-- Task 2: Top 3 Products in Each Category
-- Find the three most expensive products in each category.
-- ROW_NUMBER() ensures no more than 3 products per category.
-- ============================================================

WITH temp_table AS (
SELECT
p.product_id,
p.product_name,
c.category_name,
c.category_id,
p.list_price,
ROW_NUMBER() OVER (
PARTITION BY c.category_id
ORDER BY p.list_price DESC
) AS ranked_price
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id
)

SELECT
tt.product_id,
tt.product_name,
tt.category_name,
tt.category_id,
tt.list_price,
tt.ranked_price
FROM temp_table tt
WHERE tt.ranked_price <= 3;

-- ============================================================
-- Task 3: Previous Product Price
-- Compare each product's price with the previous product
-- within the same category, ordered by product_id.
-- ============================================================

SELECT
p.product_id,
p.product_name,
p.category_id,
p.list_price,
LAG(list_price) OVER (
PARTITION BY p.category_id
ORDER BY p.product_id
) AS previous_price,
p.list_price - LAG(list_price) OVER (
PARTITION BY p.category_id
ORDER BY p.product_id
) AS price_difference
FROM products p;

-- ============================================================
-- Task 4: Price Change Percentage
-- Calculate the percentage change between the current product
-- price and the previous product price within the same category.
-- ============================================================

WITH temp_table AS (
SELECT
p.product_id,
p.product_name,
p.category_id,
p.list_price,
LAG(p.list_price) OVER (
PARTITION BY p.category_id
ORDER BY p.product_id
) AS previous_price
FROM products p
)

SELECT
tt.product_id,
tt.product_name,
tt.category_id,
tt.list_price,
tt.previous_price,
(tt.list_price - tt.previous_price)
/ tt.previous_price * 100 AS price_change_percent
FROM temp_table tt;

-- ============================================================
-- Task 5: Best-Selling Product in Each Category
-- Find the product with the highest total quantity sold
-- within each category.
-- Products with equal sales receive the same rank.
-- ============================================================

WITH temp_table AS (
SELECT
p.product_id,
p.product_name,
c.category_id,
c.category_name,
SUM(oi.quantity) AS total_quantity_sold
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id
INNER JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY
p.product_id,
p.product_name,
c.category_id,
c.category_name
),
temp_rank AS (
SELECT
tt.product_id,
tt.product_name,
tt.category_id,
tt.category_name,
tt.total_quantity_sold,
DENSE_RANK() OVER (
PARTITION BY tt.category_id
ORDER BY tt.total_quantity_sold DESC
) AS sales_rank
FROM temp_table tt
)

SELECT
tr.product_id,
tr.product_name,
tr.category_id,
tr.category_name,
tr.total_quantity_sold,
tr.sales_rank
FROM temp_rank tr
WHERE tr.sales_rank = 1;

-- ============================================================
-- Task 6: Running Revenue
-- Calculate revenue for each order and cumulative revenue
-- over time.
-- ============================================================

WITH temp_table AS (
SELECT
o.order_id,
o.order_date,
SUM(oi.list_price * oi.quantity) AS order_revenue
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY
o.order_id,
o.order_date
)

SELECT
tt.order_id,
tt.order_date,
tt.order_revenue,
SUM(tt.order_revenue) OVER (
ORDER BY tt.order_date, tt.order_id
) AS running_revenue
FROM temp_table tt;
