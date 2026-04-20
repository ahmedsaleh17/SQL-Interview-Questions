-- CTAS 
USE salesdb; 




SELECT  
    DATENAME(MONTH, OrderDate) OrderMonth,
    COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate)



--Displaying the data 
SELECT 
    *
FROM Sales.MonthlyOrders

/* how to refresh CTAS ? */

IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL 
    DROP TABLE Sales.MonthlyOrders; 
GO 

SELECT  
    DATENAME(MONTH, OrderDate) OrderMonth,
    COUNT(OrderID) TotalOrders,
    SUM(Sales) TotalSales
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate)

--Displaying the data 
SELECT 
    *
FROM Sales.MonthlyOrders