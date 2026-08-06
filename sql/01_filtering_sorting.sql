/*
============================================================
Task 1: Premium Products
============================================================
Business Question:
Find all premium products priced above $1000.
Sort them by price (highest first), then by product name.

Tables Used:
- products
============================================================
*/
SELECT 
	P.PRODUCT_NAME, 
	P.LIST_PRICE,
	P.MODEL_YEAR 
FROM PRODUCTS P 
WHERE P.LIST_PRICE > 1000
ORDER BY P.LIST_PRICE DESC, P.PRODUCT_NAME ASC;
