/* Views: 
-- virtual table that view data without storing it physically*/

/*SQL TASK: 
Find the running total of sales for each month */

USE salesdb; 

WITH CTE_Monthly_Summary AS(
    SELECT  
        DATETRUNC(MONTH, OrderDate) OrderMonth,
        SUM(Sales) TotalSales
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH, OrderDate)
)


SELECT 
    OrderMonth, 
    TotalSales, 
    SUM(TotalSales) OVER(ORDER BY OrderMonth) RunningTotal
FROM CTE_Monthly_Summary


/*now we need to make this cte as view 
so different users can access it in different queries 
So we don't have to repeat the same aggregations over and over*/


CREATE OR ALTER VIEW V_Monthly_Summary AS
(
    SELECT 
        DATETRUNC(MONTH, OrderDate) OrderMonth,
        SUM(Sales) TotalSales, 
        COUNT(OrderID) TotalOrders, 
        SUM(Quantity)  TotalQuantities 
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH, OrderDate)
)


SELECT * 
FROM V_Monthly_Summary; 

-- NOW WE NEED TO TRANSFER THE VIEW TO SALES SCHEMA
ALTER SCHEMA sales TRANSFER V_Monthly_Summary


SELECT 
    *
FROM SALES.V_Monthly_Summary




-- drop view 
DROP VIEW Sales.V_Monthly_Summary



/* What if you need to update the logic of the view
you need first to get rid of the old one*/

DROP VIEW Sales.V_Monthly_Summary

CREATE VIEW Sales.V_Monthly_Summary AS(
    SELECT 
        DATETRUNC(MONTH, OrderDate) OrderMonth, 
        SUM(Sales) TotalSales, 
        COUNT(OrderID) TotalOrders
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH, OrderDate)
)


-- Another way 
-- First remove the old view
IF OBJECT_ID('Sales.V_Monthly_Summary', 'V') IS NOT NULL 
    DROP VIEW Sales.V_Monthly_Summary 
GO  
-- Then create the same views with another logic
CREATE VIEW Sales.V_Monthly_Summary AS(
    SELECT 
        DATETRUNC(MONTH, OrderDate) OrderMonth, 
        SUM(Sales) TotalSales, 
        COUNT(OrderID) TotalOrders
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH, OrderDate)
)


-- THE BEST OPTION USE : 
-- This is safer and more flexible 
-- it creates the view if it doesn’t exist or alters it if it does:

CREATE OR ALTER VIEW Sales.V_Monthly_Summary AS (
    SELECT 
        DATETRUNC(MONTH, OrderDate) OrderMonth, 
        SUM(Sales) TotalSales, 
        COUNT(OrderID) TotalOrders
    FROM Sales.Orders
    GROUP BY DATETRUNC(MONTH, OrderDate)
)

--------------------------


/*SQL TASK (HIDE COMPLEXITY USE CASE)
Provide a view that combines details from 
orders, products, customers, employees*/

IF OBJECT_ID('V_Order_details', 'V') IS NOT NULL 
    DROP VIEW V_Order_details
GO
CREATE VIEW Sales.V_Order_details AS(
    SELECT 
        O.OrderID,
        O.OrderDate, 
        p.Product,
        p.Category,
        O.Sales, 
        O.Quantity,
        COALESCE(C.FirstName, '') + ' '+ COALESCE(C.LastName,'') CustomerName,
        C.Country CustomerCountry,
        COALESCE(E.FirstName,'')+' '+COALESCE(E.LastName,'') EmployeeName, 
        CASE E.Gender
            WHEN 'F' THEN 'Female'
            WHEN 'M' THEN 'Male'
            ELSE 'Not Provided'
        END AS EmployeeGender, 
        E.Department EmployeeDepartment,
        E.Salary EmployeeSalary
    FROM Sales.Orders O  
    LEFT JOIN Sales.Products P   
    ON O.ProductID = P.ProductID
    LEFT JOIN Sales.Customers C  
    ON O.CustomerID = C.CustomerID 
    LEFT JOIN Sales.Employees E   
    ON O.SalesPersonID = E.EmployeeID
)



SELECT
    *
FROM Sales.V_Order_details





/* SQL TASK (DATA SECURITY USE CASE)
Provide a view for the EU sales team 
that combine details from all tables and excludes data related to USA */

CREATE VIEW Sales.V_EU_Order_details AS(
    SELECT 
        O.OrderID,
        O.OrderDate, 
        p.Product,
        p.Category,
        O.Sales, 
        O.Quantity,
        COALESCE(C.FirstName, '') + ' '+ COALESCE(C.LastName,'') CustomerName,
        C.Country CustomerCountry,
        COALESCE(E.FirstName,'')+' '+COALESCE(E.LastName,'') EmployeeName, 
        CASE E.Gender
            WHEN 'F' THEN 'Female'
            WHEN 'M' THEN 'Male'
            ELSE 'Not Provided'
        END AS EmployeeGender, 
        E.Department EmployeeDepartment,
        E.Salary EmployeeSalary
    FROM Sales.Orders O  
    LEFT JOIN Sales.Products P   
    ON O.ProductID = P.ProductID
    LEFT JOIN Sales.Customers C  
    ON O.CustomerID = C.CustomerID 
    LEFT JOIN Sales.Employees E   
    ON O.SalesPersonID = E.EmployeeID
    WHERE C.Country != 'USA'
)



--access the view
SELECT 
    *
FROM Sales.V_EU_Order_details