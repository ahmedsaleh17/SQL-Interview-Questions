/* window function do the same operation as group by, 
but without lose the level of details of rows
-- Functions that perform calculations across a set of rows related to the current row, 
without collapsing the result set (unlike GROUP BY).
*/



/*sql task: 
Find the total sales across all orders */

USE salesdb; 


SELECT
    SUM(Sales)
FROM Sales.Orders

-- Find the total sales for each product

SELECT
    ProductID,
    SUM(Sales) Total_sales  
FROM Sales.Orders 
GROUP BY ProductID


/* Find the total sales for each product, 
additionally provide details such orderid, orderdate*/

SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales, 
    SUM(Sales) OVER() Total_sales,
    SUM(Sales) OVER(PARTITION BY ProductID) Total_sales_by_products
FROM Sales.Orders


/* Rank each order based on their sales 
from the highest to lowest */

SELECT 
    OrderID,
    OrderDate,
    Sales,
    RANK() OVER(ORDER BY sales DESC) RankSales
from Sales.Orders 

--


/* Aggregate Function 
- COUNT()
- SUM()
- MIN()
- MAX()
- AVG()
*/

-- COUNT FUNCTION 
/* COUNT | USE CASES : 
#1 Overall Analysis 
#2 Category Analysis 
#3 Quality Checks: Identify eihter nulls or duplicates.*/


-- find the total numbers of orders for each customer
-- Additionally provide details such orderid , orderdate

SELECT  
    OrderID,
    OrderDate,
    CustomerID,
    COUNT(*) OVER() TotalOrders,
    COUNT(*) OVER(PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders


/* sql Task: 
find the total number of customers 
additionally provide all customer's details
*/


SELECT 
    *, 
    COUNT(*) OVER() TotalCustomers,
    COUNT(Score) OVER() TotalScore,
    COUNT(Country) OVER() TotalCountries
FROM Sales.Customers


/* Data Quality Issue 
-- Duplicates leads to inaccuracies in analysis 
-- COUNT() Can be used to identifiy duplicates*/

/* SQL Task: 
check whether the table 'ordersarchive'
contains any duplicates rows */

SELECT 
    *
FROM (
    SELECT 
        DISTINCT OrderID,
        COUNT(*) OVER(PARTITION BY OrderID) checkpk
    FROM Sales.OrdersArchive
)T
WHERE checkpk >1




-- SUM FUNCTION 

/*SQL TASK: 
Find the total sales across all orders and 
the total sales for each product 
additionally, provide details such as order id and order date */

SELECT  
    OrderID,
    OrderDate,
    ProductID,  
    SUM(Sales) OVER() TotalSales, 
    SUM(Sales) OVER(PARTITION BY ProductID) SalesByProducts
FROM Sales.Orders 


/* Comparision Analysis | USE CASE
Compare the current value and aggregated value of window functions 

# Part-to-Whole analysis
compare current sales to total sales 
comman analyzes in order to understand the performance of each order 
compared to the total */

/* SQL TASK: 
Find the percentage contribution of 
each product's sales to the total sales
*/


SELECT 
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER() TotalSales,
    ROUND(CAST(Sales AS float) / SUM(Sales) OVER()*100, 2) PercentageOfTotal
FROM Sales.Orders




-- AVG FUNCTION 

/*SQL TASK: 
Find the average sales across all orders and 
the average sales for each product 
additionally, provide details such as order id and order date */

SELECT 
    OrderID,
    OrderDate, 
    ProductID, 
    Sales,
    AVG(Sales) OVER() AvgSales, 
    AVG(Sales) OVER(PARTITION by ProductID) AvgSalesByProudct
FROM Sales.Orders

/* SQL Task: 
find the average scores of customers, 
additionally provide details such as customer id , and lastname */ 


SELECT 
    CustomerID, 
    LastName, 
    score, 
    AVG(Score) OVER() AvgScore,
    AVG(COALESCE(Score, 0)) OVER() AvgScoreWithoutNulls
FROM Sales.Customers; 



/* Sql Task: 
Find all orders where sales are
higher than the average sales across all orders */

SELECT 
    *
FROM
(
    SELECT 
        OrderID,
        ProductID,
        Sales,
        AVG(Sales) OVER() AvgSales
    FROM Sales.Orders
)t
where Sales > AvgSales



/* SQL Task : 
Find the highest & lowest sales across all orders
and Find the highest & lowest sales for each product
additionally, provide details such as order Id and order Date */


SELECT
    OrderID,
    OrderDate, 
    ProductID, 
    Sales, 
    MAX(Sales) OVER() highestSales, 
    MIN(Sales) OVER() LowestSales,
    MAX(Sales) OVER(PARTITION BY ProductID) highestSalesByProduct, 
    MIN(Sales) OVER(PARTITION BY ProductID) LowestSalesByProduct

FROM Sales.Orders 



/* SQL Task : 
Show The employess with the highest salaries*/


SELECT  
    *
FROM SaleS.Employees
WHERE Salary IN(

SELECT 
    MAX(Salary)
FROM Sales.Employees
)




-- Running Total VS Rolling Total concepts 

-- calculate the moving average of sales for each product OVER TIME


SELECT 
    OrderDate, 
    ProductID, 
    Sales,
    AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
    AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg
FROM Sales.Orders


/* SQL Task: 
Calcualte the moving average of sales for each 
product over time, including only the next order*/

SELECT 
    OrderDate, 
    ProductID, 
    Sales,
    AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
    AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
    AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders
