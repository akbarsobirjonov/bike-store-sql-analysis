/*
============================================================
Task 11: Products Above Average Price
============================================================

Business Question:
Find all products whose price is above the average
price of all products.
============================================================
*/
SELECT 
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	P.LIST_PRICE
FROM PRODUCTS P 
WHERE P.LIST_PRICE > (
	SELECT AVG(P.LIST_PRICE)
	FROM PRODUCTS P
)
ORDER BY P.LIST_PRICE DESC

/*
============================================================
Task 12: Customers Above Average Order Count
============================================================

Business Question:
Find customers whose number of orders is above the
average number of orders among customers with orders.
============================================================
*/
SELECT 
	C.CUSTOMER_ID,
	C.FIRST_NAME AS NAME,
	C.LAST_NAME AS SURNAME,
	COUNT(O.ORDER_ID) AS ORDERS_COUNT
FROM CUSTOMERS C 
INNER JOIN ORDERS O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME
HAVING COUNT(O.ORDER_ID) > (
	SELECT AVG(ORDERS_COUNT)
	FROM (
    	SELECT
        	CUSTOMER_ID,
        	COUNT(ORDER_ID) AS ORDERS_COUNT
    	FROM ORDERS
    	GROUP BY CUSTOMER_ID
	) AS T
)
ORDER BY ORDERS_COUNT  DESC 

/*
============================================================
Task 13: Products Above Category Average
============================================================

Business Question:
Find products whose price is above the average price
within their own category.
============================================================
*/
SELECT 
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	P.LIST_PRICE,
	C.CATEGORY_NAME
FROM  PRODUCTS P 
INNER JOIN CATEGORIES C 
ON P.CATEGORY_ID = C.CATEGORY_ID
WHERE P.LIST_PRICE > (
	SELECT AVG(P2.LIST_PRICE)
	FROM PRODUCTS P2 
	WHERE P.CATEGORY_ID = P2.CATEGORY_ID 
)
