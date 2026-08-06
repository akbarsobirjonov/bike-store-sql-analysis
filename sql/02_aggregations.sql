
/*
============================================================
Task 2: Product Statistics by Category
============================================================
Business Question:
Show the number of products and price statistics for each category.

Tables Used:
- products
- categories
============================================================
*/
SELECT 
	C.CATEGORY_NAME,
	COUNT(P.PRODUCT_ID) AS TOTAL_PRODUCTS,
	MIN(P.LIST_PRICE) AS MIN_PRICE,
	MAX(P.LIST_PRICE) AS MAX_PRICE,
	ROUND(AVG(P.LIST_PRICE), 2) AS AVG_PRICE
FROM CATEGORIES C 
INNER JOIN PRODUCTS P 
ON C.CATEGORY_ID = P.CATEGORY_ID 
GROUP BY  C.CATEGORY_NAME
ORDER BY TOTAL_PRODUCTS DESC;

/*
============================================================
Task 3: Expensive Categories
============================================================
Business Question:
Find categories where the average product price exceeds $2000.

Tables Used:
- products
- categories
============================================================
*/
SELECT 
	C.CATEGORY_NAME,
	COUNT(P.PRODUCT_ID) AS TOTAL_PRODUCTS,
	AVG(P.LIST_PRICE) AS AVG_PRICE
FROM CATEGORIES C 
INNER JOIN PRODUCTS P 
ON C.CATEGORY_ID = P.CATEGORY_ID 
GROUP BY C.CATEGORY_NAME 
HAVING AVG(P.LIST_PRICE) > 2000
ORDER BY AVG_PRICE DESC;

/*
============================================================
Task 4: Brand Price Analysis
============================================================
Business Question:
Analyze brands with more than 5 products and compare their prices.

Tables Used:
- products
- brands
============================================================
*/
SELECT 
	B.BRAND_NAME,
	COUNT(P.PRODUCT_ID) AS TOTAL_PRODUCTS,
	AVG(P.LIST_PRICE) AS AVG_PRICE,
	MAX(P.LIST_PRICE) AS MAX_PRICE
FROM BRANDS B 
INNER JOIN PRODUCTS P 
ON B.BRAND_ID = P.BRAND_ID
GROUP BY B.BRAND_NAME 
HAVING COUNT(P.PRODUCT_ID) > 5
ORDER BY AVG_PRICE DESC;
