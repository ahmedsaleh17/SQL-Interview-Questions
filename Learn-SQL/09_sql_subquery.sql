/*sql task:find the products that have a price higher 
than the average price of all products*/

use salesdb; 

-- 1stsol:
SELECT 
    Product
FROM  Sales.Products
WHERE Price >
    (SELECT 
        AVG(Price)
    FROM Sales.Products)


-- 2ND SOL:
SELECT 
    Product
FROM(
    SELECT 
        PRODUCT, 
        Price, 
        AVG(Price) OVER() AvgPrice
    FROM Sales.Products)T   
WHERE Price > AvgPrice


/* Rank customers based on their total amount of sales*/


SELECT  
    CustomerID, 
    SUM(Sales) TotalSales,
    ROW_NUMBER() OVER(ORDER BY SUM(Sales) DESC) rank
FROM Sales.Orders
GROUP BY CustomerID


-- another sol 
SELECT 
    *, 
    ROW_NUMBER() OVER (ORDER BY TotalSales DESC)
FROM (
    SELECT
        CustomerID, 
        SUM(Sales) TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID 
)T  



/* sql task : 
Show the product ids, names, prices, and the total number of orders */

SELECT
    *, 
    (SELECT COUNT(*) FROM Sales.Orders)  TotalOrders
FROM Sales.Products



/* JOIN Subquery :
Used to prepare the data (filtering or aggregation)
before joining it with other tables*/


/* sql task : 
Show all customers details and find the total orders for each customer*/

-- 1st sol Using subquery
SELECT 
    C.*, 
    COALESCE(T.TotalOrders, 0) TotalOrders
FROM Sales.Customers C 
LEFT JOIN (
    SELECT 
        CustomerID, 
        COUNT(OrderID) TotalOrders
    FROM Sales.Orders
    GROUP BY CustomerID
)T 
ON C.CustomerID = T.CustomerID


--2nd 
SELECT 
    DISTINCT C.*,
    COUNT(O.OrderID) OVER(PARTITION BY C.CustomerID) TotalOrders
FROM Sales.Customers C  
LEFT JOIN Sales.Orders O
ON O.CustomerID = C.CustomerID




/*WHERE Subquery 
Used for complex filtering logic and 
makes query more flexible and dynamic*/

/* SQL Task :
show the detail of orders made by customers in Germany*/


--MAINQUERY 
SELECT 
    *
FROM Sales.Orders
WHERE CustomerID IN(
    --SUBQUERY
    SELECT
        CustomerID
    FROM Sales.Customers
    WHERE  Country = 'Germany'
)



/* SUBQUERY 
ANY | ALL OPERATOR 

ANY OPERATOR: 
-- Checks if a value matches any value from alist 

ALL OPERATOR : 
-- Checks if a value matches all values with in a list
*/

/* sql task: 
Find female employess whose salaries are greater
than the salaries of any male employees */

--MAIN QUERY
SELECT 
    EmployeeID, 
    FirstName, 
    Gender,
    Salary
FROM Sales.Employees
WHERE Gender = 'F' AND 
Salary > ANY (
    -- NOT SCALAR SUBQUERY
    SELECT 
        Salary
    FROM Sales.Employees
    WHERE Gender = 'M'
)

/* sql task: 
Find female employess whose salaries are greater
than the salaries of all male employees */

--MAIN QUERY
SELECT 
    EmployeeID, 
    FirstName, 
    Gender,
    Salary
FROM Sales.Employees
WHERE Gender = 'F' AND 
Salary > all (
    -- NOT SCALAR SUBQUERY
    SELECT 
        Salary
    FROM Sales.Employees
    WHERE Gender = 'M'
)



/* sql task : 
Show all customers details and find the total orders for each customer*/

-- using correlated subquery
SELECT
    C.*,
    (SELECT COUNT(*) FROM Sales.Orders) TotalOrders, 
    (SELECT COUNT(*) FROM Sales.Orders O WHERE C.CustomerID = O.CustomerID) TotalOrdersByCustomers
FROM Sales.Customers C  





-- EXISTS OPERATOR 
-- Check if a subquery returns any rows 

/*show the details of orders mabe by customers in germany */


SELECT 
    *
FROM Sales.Orders o   
WHERE EXISTS(
    SELECT 1
    FROM Sales.Customers c
    WHERE Country = 'Germany' 
    AND o.CustomerID = c.CustomerID
)



-- Find employees who earn more than the average salary in their department.

-- CORRELATED SUBQUERY
SELECT
    *
FROM Sales.Employees E
WHERE E.Salary >
(
    SELECT AVG(E2.Salary)
    FROM Sales.Employees E2
    WHERE E.Department = E2.Department 
) 


/*
How It Works Internally (Execution Flow)

Let’s simulate how the SQL Server database engine executes it:

1. The outer query starts scanning the Employees table — one row at a time.

2. For each row (e):
    - The engine runs the subquery
    ```
        SELECT AVG(E2.Salary)
        FROM Sales.Employees E2
        WHERE E.Department = E2.Department 
    ```
    Here E.Department comes from the current row in the main query

3. The subquery computes the average salary for that department 
4. Then it checks if the current employee's salary > that average 
5. If true --> include that employee in the final result 
6. This repeats for every row
*/


