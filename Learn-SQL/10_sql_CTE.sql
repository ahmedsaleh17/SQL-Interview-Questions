USE SALESDB; 
-- Step1: Find the total sales per customer(Standalone CTE)

WITH CTE_Total_sales AS
(
    SELECT  
        CustomerID, 
        SUM(Sales) TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
)
-- Step2: Find the last order date per customer(Standalone CTE)
, CTE_Last_Order AS
(
    SELECT 
        CustomerID, 
        MAX(OrderDate) Last_order
    FROM Sales.Orders
    GROUP BY CustomerID
)
-- Step3: Rank Customers based on their total sales per Customer(Nested CTE)
, CTE_rank AS
(
    SELECT  
        CustomerID, 
        TotalSales,
        RANK() OVER(ORDER BY TotalSales DESC) ranking 
    FROM CTE_Total_sales
)


-- Step4: Segment Customers based on their total sales (Nested CTE)
, CTE_Customer_segments AS 
(
    SELECT 
        CustomerID, 
        TotalSales, 
        CASE  
            WHEN TotalSales > 100 THEN 'High'
            WHEN TotalSales > 50  THEN 'Medium'
            ELSE 'Low'
        END CustomerSegments
    From CTE_Total_sales
)




-- SELECT *
-- FROM CTE_rank


--Main Query
SELECT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName,   
    Cts.TotalSales,
    clo.Last_order,
    ctr.ranking, 
    CCS.CustomerSegments
FROM Sales.Customers C  
LEFT JOIN CTE_Total_sales Cts  
on c.CustomerID = Cts.CustomerID
LEFT JOIN CTE_Last_Order clo 
ON C.CustomerID = clo.CustomerID
LEFT JOIN CTE_rank ctr  
on c.CustomerID = ctr.CustomerID
LEFT JOIN CTE_Customer_segments CCS 
ON CCS.CustomerID = C.CustomerID
----------------------------------------


-- RECURSIVE CTE


-- sql task : generate a sequeence of numbers from 1 to 20

WITH Series AS(
    --Anchor Query
    SELECT 1 AS MyNumber
    UNION ALL 
    --Recursive Query
    SELECT MyNumber + 1
    FROM Series
    WHERE MyNumber < 20
)

--Main Query
SELECT * 
FROM Series


/* Example 2: Recursive CTE

Used for hierarchical data (e.g., employees and managers).*/


WITH CTE_EmployeesHierachy AS 
(
    -- Anchor Query
    SELECT 
        EmployeeID, 
        FirstName, 
        LastName, 
        ManagerID,
        1 AS Level 
    FROM Sales.Employees
    WHERE ManagerID IS NULL


    UNION ALL 

    -- RECURSIVE QUERY
    SELECT 
        E.EmployeeID, 
        E.FirstName,
        E.LastName, 
        E.ManagerID, 
        CEH.Level + 1 
    FROM Sales.Employees E 
    INNER JOIN CTE_EmployeesHierachy CEH   
    ON E.ManagerID = CEH.EmployeeID
)


SELECT 
    *
FROM  CTE_EmployeesHierachy