/* RANKING FUNCTIONS
-- ROW_NUMBER()  >> Assign a unique number to each row in a window
--RANK()         >> Assign a rank to each row in a window, with gaps
--DENSE_RANK()   >> Assign a rank to each row in a window, without gaps
--CUME_DIST()    >> Calculates the cumulative distribution of a value within a set of values
--PERCENT_RANK() >> Returns the percentile ranking number of row
--NTILE(n)       >> Divides the rows into a specified number of groups */

USE salesdb;

/* Integer Based Ranking
-- ROW_NUMBER FUNCTION 
-- RANK FUNCTION 
-- DENSE_RANK FUNCTION */



/*SQL TASK : 
Rank the orders based on their sales from the highest to the lowest */

SELECT
    OrderID,
    sales,
    ROW_NUMBER() OVER(ORDER by sales DESC) SalesRank_Row,
    RANK() OVER(ORDER by sales DESC) SalesRank_Rank,
    DENSE_RANK() OVER(ORDER by sales DESC) SalesRank_Dense
FROM Sales.Orders


/* Use Case  TOP-N ANALYSIS
find the top highes sales for each product */

SELECT
    ProductID,
    Sales
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY SALES DESC) RN
    FROM Sales.Orders
)T
WHERE RN = 1

-- SOLUTION BY USING GROUP BY

SELECT
    ProductID,
    MAX(Sales) MAXSALES
FROM Sales.Orders
GROUP BY ProductID


/* Bottom-N analysis 
Find th lowest 2 customers based on their total sales */

SELECT
    CustomerID,
    TotalSales
FROM (
    SELECT
        CustomerID,
        SUM(Sales) TotalSales,
        ROW_NUMBER() OVER(ORDER BY SUM(Sales)) Rank
    FROM Sales.Orders
    GROUP BY CustomerID) T
WHERE [Rank] <=2;
/* rule : 
Columns used in GROUP BY and WINDOW Function must be the same*/



/* Generate Unique IDs use case 
assign unique IDs to the rows of the 'orders archive' table*/

SELECT
    ROW_NUMBER() OVER(ORDER BY OrderDate) ID,
    *
FROM Sales.OrdersArchive


/* Identify Duplicates | use case
Identify duplicate rows in the table 'orders archive'
and return a clean result without any duplicates */


SELECT
    ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) RN,
    *
FROM Sales.OrdersArchive

-- NOW TO IDENTIFY DUPLICATES 

SELECT *
FROM (
    SELECT
        ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) RN,
        *
    FROM Sales.OrdersArchive
)T
WHERE RN >1

-- return a clean result without any duplicates
SELECT *
FROM(
    SELECT
        ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) RN,
        *
    FROM Sales.OrdersArchive
)T
WHERE RN =1



-- NTILE FUNCTION 


SELECT
    OrderID,
    Sales,
    NTILE(1) OVER(ORDER BY Sales DESC) OneBucket,
    NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
    NTILE(3) OVER(ORDER BY Sales DESC) ThreeBucket,
    NTILE(4) OVER(ORDER BY Sales DESC) FourBucket
FROM Sales.Orders

/*NTILE FUNCION | USE CASE 
# Data Segmentation 
# Equalizing 
# Load Processing  */


/* Data segmentation Task
segment all orders into 3 categories : 
High, medium and low sales 
*/

SELECT
    OrderID,
    Sales,
    CASE 
        WHEN Buckets = 1 THEN 'High' 
        WHEN Buckets = 2 THEN 'Medium'
        ELSE 'Low' 
    END AS SalesSegmentations
FROM (
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER(ORDER BY SaleS DESC) Buckets
    FROM Sales.Orders
)T

/*Equalizing Loads
-- in order to export data, divide teh orders into 2 batchs*/

SELECT
    NTILE(2) OVER(ORDER BY OrderID) Buckets,
    *
FROM Sales.Orders


-- moving BATCH 1 to mydatabase 
SELECT *
INTO mydatabase.dbo.OrdersBatch1
FROM (

    SELECT
        NTILE(2) OVER(ORDER BY OrderID) Buckets,
        *
    FROM Sales.Orders

)T
WHERE Buckets =1

-- moving BATCH 2 to  mydatabase 
SELECT *
INTO mydatabase.dbo.OrdersBatch2
FROM (

    SELECT
        NTILE(2) OVER(ORDER BY OrderID) Buckets,
        *
    FROM Sales.Orders

)T
WHERE Buckets =2


USE MyDatabase;

-- Data Completeness Check 
WITH All_orders AS 
(
    SELECT *
    FROM MyDatabase.dbo.OrdersBatch1
UNION ALL
    SELECT *
    FROM MyDatabase.dbo.OrdersBatch2
)

SELECT 
    *
FROM W3schoolDB.dbo.orders
EXCEPT
SELECT
    *
FROM All_orders
-- GET THE SAME TABLE




-- CUME_DIST & PERCENT_RANK 


SELECT
    OrderID,
    Sales,
    CUME_DIST() OVER(ORDER BY SALES ASC) DIST,
    ROUND (PERCENT_RANK() OVER(ORDER BY SALES ASC),2) PER_RANK
FROM Sales.Orders


/*SQL TASK : 
Find the products that fall within 
the highest 40% of prices */


SELECT
    Product
FROM (
    SELECT
        Product,
        Price,
        CUME_DIST() OVER(ORDER BY Price ASC) dist,
        PERCENT_RANK() OVER(ORDER BY Price ASC) PER_RANK
    FROM Sales.Products
)T
WHERE PER_RANK >=0.4