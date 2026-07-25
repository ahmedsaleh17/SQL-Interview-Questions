/*
Golden Rule: 
Sql optimizer response differently for different size of tables so this means that 

If you have a small table and you follow the best practices of writing query,
you might not notice any performance differences but if you have millions or 100 of millions 
and follow the best practices, you actually notice how things will be faster

So 
Always check the execution plan to confirm performance improvements when optimizeing you query \

If there's no improvement then focus on readability 
*/


-- Fetching Data - best practices  -- 


-- Tip 1: Select only what you need 

-- bad practice 
SELECT 
    * 
FROM transactions


-- good practice 
SELECT  
    transaction_dt,
    customer_id, 
    payment_method, 
    total_gross_amount
FROM transactions


-- Tip 2: Avoid unnecessary distinct and order by 

-- bad practice 
SELECT  
    DISTINCT transaction_id, transaction_code
FROM transactions
ORDER BY transaction_id


-- good practice
SELECT  
    transaction_id, 
    transaction_code
FROM transactions



-- Tip 3: for exploration purpose, limit rows 
SELECT
    TOP 10
    transaction_id, 
    transaction_dt,
    payment_method
FROM transactions

-----------------------------------------------------------------------------------



-- Filter data - Best Practices -- 

-- Tip 4: create nonclustered index on frequently used columns in WHERE Claues 

SELECT 
    transaction_id, 
    transaction_dt,
    customer_id, 
    payment_method
FROM transactions
WHERE payment_method = 'Card'


-- create index 
CREATE INDEX IX_TRANSACTIONS_PAYMENT 
ON transactions(payment_method)


-- Tip 5: Avoid applying functions to columns in WHERE Clause 
-- why: because functions on columns can block index usage 


-- bad practice 
SELECT 
    *
FROM transactions
WHERE LOWER(payment_method) = 'Wallet'


-- good practice 
SELECT
    transaction_id,
    transaction_dt,
    payment_method
FROM transactions
WHERE payment_method = 'Wallet'


-- bad practice 

SELECT 
    customer_id, 
    first_name, 
    phone, 
    date_of_birth, 
    gender
FROM customers
WHERE SUBSTRING(first_name, 1, 1) = 'A'

-- good practice 

SELECT 
    customer_id, 
    first_name, 
    phone, 
    date_of_birth, 
    gender
FROM customers
WHERE first_name LIKE 'A%'


-- bad practice 

SELECT
    *
FROM transactions
WHERE YEAR(transaction_dt) = 2025 

-- good  practice 

SELECT
    *
FROM transactions
WHERE transaction_dt BETWEEN '2025-01-01' and '2025-12-31'




-- tip 6: Avoid using leading wildcards, because they prevent index usage 

-- bad practice 
SELECT
    *
FROM customers
WHERE first_name LIKE '%A%'

-- good practice 
SELECT
    *
FROM customers
WHERE first_name LIKE 'A%'


-- Tip 7: Use IN instead of multiple OR 

-- bad practice 
SELECT
    *
FROM transactions
WHERE customer_id = 1 OR customer_id = 2 OR customer_id = 3 

-- good practice
SELECT 
    *
FROM transactions
WHERE customer_id IN (1, 2, 3)


------------------------------------------------------------------

-- Joining Data - Best Practices -- 


-- Tip 8: Understand the speed of joins and user INNER JOIN when possible 

-- Best Performance  first INNER JOIN THEN LEFT OR RIGHT THEN OUTER 

SELECT 
    t.transaction_dt, 
    c.customer_id, 
    t.payment_method,
    t.[status]
FROM transactions t
INNER JOIN customers c  
on t.customer_id = c.customer_id



-- Tip 9: Use Explicit Join (ANSI Join) rather than Implicit Join (NON ANSI JOIN )


-- BAD PRACICE 
SELECT
    t.transaction_dt, 
    c.customer_id, 
    t.payment_method,
    t.[status]
FROM transactions T  , customers C
WHERE T.customer_id = C.customer_id


-- GOOD PRACTICE 
SELECT 
    t.transaction_dt, 
    c.customer_id, 
    t.payment_method,
    t.[status]
FROM transactions t
INNER JOIN customers c  
on t.customer_id = c.customer_id




-- Tip 10: Make sure to index the columns used in the ON clause 

SELECT 
    t.transaction_dt, 
    c.customer_id, 
    t.payment_method,
    t.[status]
FROM transactions t
INNER JOIN customers c  
on t.customer_id = c.customer_id

-- If there is no Indexes on table, create them to optimize Joining Performance 

CREATE INDEX IX_TRANSACTIONS_CUSTOMER_ID 
ON transactions(customer_id)





-- Tip 11:  For big tables, it's better to filter data before joining 

-- try to isolate teh preparation step in a CTE or subquery

SELECT 
    c.customer_id, 
    card_trans.branch_id, 
    card_trans.transaction_dt,
    card_trans.total_net_amount
FROM customers C  
JOIN 
(
    -- prepare table first before joining 
    SELECT 
        customer_id,
        transaction_dt, 
        branch_id, 
        total_net_amount
    FROM transactions 
    WHERE payment_method = 'Card'
) card_trans
ON c.customer_id = card_trans.customer_id



-- Tip 12: Aggregate data before joining (big tables)

-- best practice for small-medium tables 

SELECT
    C.customer_id, 
    C.first_name, 
    COUNT(T.transaction_id) AS TRANS_COUNT
FROM customers C 
JOIN transactions T 
ON C.customer_id = T.customer_id
GROUP BY C.customer_id, C.first_name

-- best practice for BIG tables 

SELECT
    C.customer_id, 
    C.first_name, 
    C.date_of_birth, 
    C.email, 
    trans_counts.TotalTransactions
FROM customers C 
JOIN 
(
    SELECT 
        customer_id, 
        COUNT(*) TotalTransactions
    FROM transactions
    GROUP BY customer_id
)trans_counts
ON C.customer_id = trans_counts.customer_id



-- tip 13: check for Nested Loops and use sql hints for big tables 


SELECT
    C.customer_id, 
    C.first_name, 
    COUNT(T.transaction_id) AS TRANS_COUNT
FROM customers C 
JOIN transactions T 
ON C.customer_id = T.customer_id
GROUP BY C.customer_id, C.first_name
OPTION (HASH JOIN)



-- Tip 14: use UNION ALL instead of UNION IF duplicates are acceptable OR you don't have duplicates 
SELECT  
    customer_id, first_name
FROM customers
WHERE gender = 'M'

UNION ALL

SELECT
    customer_id, 
    first_name
FROM customers 
WHERE gender = 'F'


-- if duplicates are not acceptable 
-- USE UNION ALL + DISTINCT instead of UNION 

SELECT 
DISTINCT customer_id, first_name
FROM 
(
    SELECT  
        customer_id, first_name
    FROM customers
    WHERE gender = 'M'

    UNION ALL 

    SELECT
        customer_id, 
        first_name
    FROM customers 
    WHERE gender = 'F'
)T

---------------------------------------------------------------------------------


-- AGGREGATING DATA - BEST PRACTICES -- 

-- Tip 15: Use COLUMNSTORE INDEX for aggregations on large table 

SELECT
    customer_id, 
    COUNT(transaction_id)
FROM transactions
GROUP BY customer_id 


-- CREATE CLUSTERED COLUMNSTORE INDEX IX_transactions_columnstore ON transactions 




-- Tip 16: Pre-aggregate data and store it in new table for reporting 
SELECT

    FORMAT(transaction_dt, 'MMM yyyy') MONTH_year,
    COUNT(transaction_id) TotalTransactions
INTO transactions_summary 
FROM transactions
GROUP BY FORMAT(transaction_dt, 'MMM yyyy')




-- ---------------------------------------------------------------------------------------



--   SUBQUERY - BEST PRACTICES  --  

-- SHOW ORDERS FOR CUSTOMERS IN USA 

USE SalesDB ; 

-- Use Join with Small tables 
SELECT
    O.OrderID,
    O.OrderDate,
    O.CustomerID, 
    O.Sales
FROM Sales.Orders O 
JOIN Sales.Customers C  
ON O.CustomerID = C.CustomerID 
AND C.Country = 'USA'


-- USE EXISTS WITH SMALL TABLE
SELECT
    *
FROM Sales.Orders O
WHERE EXISTS 
(
    SELECT 1
    FROM SALES.CUSTOMERS C 
    WHERE C.CustomerID = O.CustomerID 
    AND C.COUNTRY = 'USA'
)




-- using SUBQUERY (BAD PRACTICE FOR BIG TABLES )
SELECT *
FROM Sales.Orders
WHERE CustomerID IN
(
    SELECT
        CustomerID
    FROM Sales.Customers 
    WHERE Country = 'USA'
)
