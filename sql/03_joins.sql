/*
============================================================
03 — JOINs
============================================================

This file contains practical SQL queries demonstrating
JOIN operations using the BikeStores database.

Topics:
- INNER JOIN
- LEFT JOIN
- Multiple JOINs
- JOIN with aggregation
- JOIN with HAVING

Database:
- PostgreSQL
- BikeStores
============================================================
*/

/*
============================================================
Task 1: Product Catalog
============================================================

Business Question:
Create a unified product catalog containing product,
brand, and category information.
============================================================
*/
-- Task 1
SELECT 
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	B.BRAND_NAME,
	C.CATEGORY_NAME,
	P.MODEL_YEAR,
	P.LIST_PRICE
FROM PRODUCTS P 
INNER JOIN CATEGORIES C 
ON C.CATEGORY_ID = P.CATEGORY_ID 
INNER JOIN BRANDS B 
ON B.BRAND_ID = P.BRAND_ID 
ORDER BY B.BRAND_NAME, C.CATEGORY_NAME, P.LIST_PRICE DESC

/*
============================================================
Task 2: Products Available in Stores
============================================================

Business Question:
Identify products currently available in each store
and show their stock quantity.
============================================================
*/
SELECT 
	S.STORE_NAME,
	P.PRODUCT_NAME,
	S2.QUANTITY
FROM STORES S
INNER JOIN STOCKS S2  
ON S.STORE_ID = S2.STORE_ID
INNER JOIN PRODUCTS P 
ON S2.PRODUCT_ID = P.PRODUCT_ID 
WHERE S2.QUANTITY > 0
ORDER BY 
	S.STORE_NAME,
	P.PRODUCT_NAME 

/*
============================================================
Task 3: Orders Overview
============================================================

Business Question:
Show order information including the customer, store,
and staff member responsible for the order.
============================================================
*/
SELECT 
	O.ORDER_ID,
	C.FIRST_NAME as customer_name,
	S.STORE_NAME as staff_name,
	S2.FIRST_NAME,
	O.ORDER_STATUS,
	O.ORDER_DATE
FROM STORES S
INNER JOIN STAFFS S2
ON S.STORE_ID = S2.STORE_ID 
INNER JOIN ORDERS O
ON O.STAFF_ID = S2.STAFF_ID 
INNER JOIN CUSTOMERS C 
ON O.CUSTOMER_ID = C.CUSTOMER_ID 
ORDER BY O.ORDER_DATE DESC 

/*
============================================================
Task 4: Sales by Store
============================================================

Business Question:
Analyze order activity for each store, including stores
that currently have no orders.
============================================================
*/
SELECT 
	S.STORE_NAME,
	COUNT(O.ORDER_ID) AS QUANTITY,
	MIN(O.ORDER_DATE) AS FIRST_ORDER,
	MAX(O.ORDER_DATE) AS LAST_ORDER
FROM STORES S 
LEFT JOIN ORDERS O 
ON S.STORE_ID = O.STORE_ID 
GROUP BY S.STORE_NAME, S.STORE_ID 
ORDER BY QUANTITY DESC
	
/*
============================================================
Task 5: Top Customers by Orders
============================================================

Business Question:
Identify customers who have placed at least three orders
and analyze their ordering activity.
============================================================
*/
SELECT 
	C.FIRST_NAME AS NAME,
	C.LAST_NAME AS LAST_NAME,
	COUNT(O.ORDER_ID) AS QUANTITY,
	MIN(O.ORDER_DATE) AS FIRST_ORDER, 
	MAX(O.ORDER_DATE) AS LAST_ORDER
FROM CUSTOMERS C 
LEFT JOIN ORDERS O
ON O.CUSTOMER_ID = C.CUSTOMER_ID 
GROUP BY C.FIRST_NAME, C.CUSTOMER_ID, C.LAST_NAME
HAVING COUNT(O.ORDER_ID) >= 3
ORDER BY QUANTITY DESC, NAME