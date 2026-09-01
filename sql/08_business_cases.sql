-- ============================================================
-- TASK 1 — TOP CUSTOMERS BY REVENUE
-- BUSINESS QUESTION:
-- WHO ARE THE TOP 10 CUSTOMERS BY TOTAL REVENUE GENERATED?
-- ============================================================

select
	C.CUSTOMER_ID,
	C.FIRST_NAME,
	C.LAST_NAME,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as TOTAL_REVENUE
from
	CUSTOMERS C
inner join ORDERS O
on
	C.CUSTOMER_ID = O.CUSTOMER_ID
inner join ORDER_ITEMS OI
on
	O.ORDER_ID = OI.ORDER_ID
group by
	C.CUSTOMER_ID,
	C.FIRST_NAME,
	C.LAST_NAME
order by
	TOTAL_REVENUE desc
limit 10;
-- ============================================================
-- TASK 2 — MONTHLY REVENUE TREND
-- BUSINESS QUESTION:
-- HOW DOES TOTAL REVENUE CHANGE FROM MONTH TO MONTH?
-- ============================================================

select
	DATE_TRUNC('MONTH', O.ORDER_DATE) as month,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as TOTAL_REVENUE
from
	ORDERS O
inner join ORDER_ITEMS OI
on
	O.ORDER_ID = OI.ORDER_ID
group by
	DATE_TRUNC('MONTH', O.ORDER_DATE)
order by
	month;
-- ============================================================
-- TASK 3 — BEST-SELLING PRODUCTS
-- BUSINESS QUESTION:
-- WHICH 10 PRODUCTS HAVE THE HIGHEST NUMBER OF UNITS SOLD?
-- ============================================================

select
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	SUM(OI.QUANTITY) as TOTAL_QUANTITY_SOLD
from
	PRODUCTS P
inner join ORDER_ITEMS OI
on
	P.PRODUCT_ID = OI.PRODUCT_ID
group by
	P.PRODUCT_ID,
	P.PRODUCT_NAME
order by
	TOTAL_QUANTITY_SOLD desc
limit 10;
-- ============================================================
-- TASK 4 — REVENUE BY CATEGORY
-- BUSINESS QUESTION:
-- WHICH PRODUCT CATEGORIES GENERATE THE HIGHEST TOTAL REVENUE?
-- ============================================================

select
	C.CATEGORY_ID,
	C.CATEGORY_NAME,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as TOTAL_REVENUE
from
	CATEGORIES C
inner join PRODUCTS P
on
	C.CATEGORY_ID = P.CATEGORY_ID
inner join ORDER_ITEMS OI
on
	P.PRODUCT_ID = OI.PRODUCT_ID
group by
	C.CATEGORY_ID,
	C.CATEGORY_NAME
order by
	TOTAL_REVENUE desc;
-- ============================================================
-- TASK 5 — STORE PERFORMANCE
-- BUSINESS QUESTION:
-- WHICH STORES GENERATE THE HIGHEST TOTAL REVENUE?
-- ============================================================

select
	S.STORE_ID,
	S.STORE_NAME,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as TOTAL_REVENUE
from
	STORES S
inner join ORDERS O
on
	S.STORE_ID = O.STORE_ID
inner join ORDER_ITEMS OI
on
	O.ORDER_ID = OI.ORDER_ID
group by
	S.STORE_ID,
	S.STORE_NAME
order by
	TOTAL_REVENUE desc;
-- ============================================================
-- TASK 6 — BRAND PERFORMANCE
-- BUSINESS QUESTION:
-- WHICH BRANDS GENERATE THE HIGHEST REVENUE AND SELL THE MOST UNITS?
-- ============================================================

select
	B.BRAND_ID,
	B.BRAND_NAME,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as TOTAL_REVENUE,
	SUM(OI.QUANTITY) as PRODUCTS_SOLD
from
	BRANDS B
inner join PRODUCTS P
on
	B.BRAND_ID = P.BRAND_ID
inner join ORDER_ITEMS OI
on
	P.PRODUCT_ID = OI.PRODUCT_ID
group by
	B.BRAND_ID,
	B.BRAND_NAME
order by
	TOTAL_REVENUE desc;
-- ============================================================
-- TASK 7 — REPEAT CUSTOMERS
-- BUSINESS QUESTION:
-- WHICH CUSTOMERS HAVE PLACED MORE THAN ONE ORDER?
-- ============================================================

select
	C.CUSTOMER_ID,
	C.FIRST_NAME,
	C.LAST_NAME,
	COUNT(O.ORDER_ID) as ORDERS_COUNT
from
	CUSTOMERS C
inner join ORDERS O
on
	C.CUSTOMER_ID = O.CUSTOMER_ID
group by
	C.CUSTOMER_ID,
	C.FIRST_NAME,
	C.LAST_NAME
having
	COUNT(O.ORDER_ID) > 1
order by
	ORDERS_COUNT desc;
-- ============================================================
-- TASK 8 — LOW-PERFORMING PRODUCTS
-- BUSINESS QUESTION:
-- WHICH 10 PRODUCTS HAVE THE LOWEST NUMBER OF UNITS SOLD?
-- ============================================================

select
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	SUM(OI.QUANTITY) as TOTAL_QUANTITY_SOLD
from
	PRODUCTS P
inner join ORDER_ITEMS OI
on
	P.PRODUCT_ID = OI.PRODUCT_ID
group by
	P.PRODUCT_ID,
	P.PRODUCT_NAME
order by
	TOTAL_QUANTITY_SOLD
limit 10;
-- ============================================================
-- TASK 9 — MONTHLY REVENUE GROWTH
-- BUSINESS QUESTION:
-- HOW DOES MONTHLY REVENUE CHANGE COMPARED WITH THE PREVIOUS MONTH?
-- ============================================================

with MONTH_TABLE as (
select
	DATE_TRUNC('MONTH', O.ORDER_DATE) as month,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as TOTAL_REVENUE
from
	ORDERS O
inner join ORDER_ITEMS OI
on
	O.ORDER_ID = OI.ORDER_ID
group by
	"MONTH"
)
select
	MT.MONTH,
	MT.TOTAL_REVENUE,
	lag(TOTAL_REVENUE) over(order by month) as PREVIOUS_MONTH_REVENUE,
	MT.TOTAL_REVENUE - lag(TOTAL_REVENUE) over(order by month) as REVENUE_CHANGE
from
	MONTH_TABLE MT
order by
	MT.MONTH;
-- ============================================================
-- TASK 10 — CATEGORY PERFORMANCE
-- BUSINESS QUESTION:
-- WHICH CATEGORIES GENERATE THE HIGHEST REVENUE, SELL THE MOST UNITS,
-- AND HAVE THE HIGHEST AVERAGE REVENUE PER PRODUCT?
-- ============================================================

with CAT_TABALE as (
select
	P.PRODUCT_ID,
	C.CATEGORY_ID,
	C.CATEGORY_NAME,
	SUM(OI.LIST_PRICE * OI.QUANTITY) as PRODUCT_REVENUE,
	SUM(OI.QUANTITY) as PRODUCTS_SOLD
from
	CATEGORIES C
inner join PRODUCTS P
on
	C.CATEGORY_ID = P.CATEGORY_ID
inner join ORDER_ITEMS OI
on
	P.PRODUCT_ID = OI.PRODUCT_ID
group by
	P.PRODUCT_ID,
	C.CATEGORY_ID,
	C.CATEGORY_NAME
)
select
	CT.CATEGORY_ID,
	CT.CATEGORY_NAME,
	SUM(CT.PRODUCTS_SOLD) as PRODUCTS_SOLD,
	SUM(CT.PRODUCT_REVENUE) as TOTAL_REVENUE,
	ROUND(AVG(CT.PRODUCT_REVENUE), 2) as AVG_PRODUCT_REVENUE
from
	CAT_TABALE CT
group by
	CT.CATEGORY_ID,
	CT.CATEGORY_NAME
order by
	TOTAL_REVENUE desc;
