use SalesDB; 

-- NULL Means Nothing (no data)
-- NULL is not equal to 0 
-- NULL is not equal to empty string 


-- functions to handle nulls

-- ISNULL FUNC( Replace null values with a specific value)

SELECT 
    OrderID, 
    ISNULL(ShipAddress, BillAddress) ShipAddress,
    BillAddress
FROM Sales.Orders

-- COALESCE FUNCTION (LIKE ISNULL BUT TAKE MANY Parameters)

SELECT 
    OrderID, 
    COALESCE(ShipAddress, BillAddress, 'unknown') ShipAddress,
    BillAddress
FROM Sales.Orders


-- use case 
-- Handle the null before doing any data aggregation.
-- find the average the score for the customers



SELECT 
    CustomerID,
    AVG(Score) OVER() AvgScores,
    AVG(COALESCE(score,0)) OVER() AvgScores2
FROM Sales.Customers


-- sql task 
/* Display the fullname of customers in a single field
and 10 bouns points to each customer's score*/



SELECT 
    COALESCE(FirstName, '') + ' ' + COALESCE(LastName , '') as [Full Name],
    ISNULL(Score, 0) +10  updatingScore
FROM Sales.Customers


-- Handle the the nulls before sorting data 
/*sort customers from the lowest to the highest 
with nulls appearing last */


SELECT 
    CustomerID, 
    Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score


/* NULLIF()
- Compares two expressions return : 
    - NUll, if they are equal 
    - First value, if they are not equal */


-- sql task : 
-- find the sales price for each order by dividing sales by quantity

SELECT 
    OrderID,
    Sales,
    Quantity,
    Sales / NULLIF(Quantity,0) as Price
FROM Sales.Orders



/* sql task 
Identify the customers who have no scores */
SELECT
    *
FROM Sales.Customers
WHERE Score IS NULL; 

/* SQL TASK: 
list all details for customers who have not placed any orders */


SELECT 
    C.*
FROM Sales.Customers C
LEFT JOIN Sales.Orders O  
ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL; 



/* NULL VS Empty String vs Blank Space */



-- WITH Orders AS(
--     SELECT 1 AS id, 'A' AS category UNION 
--     SELECT 2 , NULL UNION 
--     SELECT 3 , '' UNION
--     SELECT 4 , ' '
-- ) 



-- SELECT * INTO dbo.temp_orders 
-- FROM Orders; 

-- 

/* Data Policy: set of rules that defines how data should be handled.
-------------------------------------------------------------------
#1 Data policy 
-- only use Nulls and empty strings, but avoid blank spaces

#2 Data policy 
-- only use Nulls and avoid using empty strings and blank spaces

#3 Data Policy 
-- use the default value 'unknown and avoid using nulls, empty strings and blank space
*/

SELECT *,
TRIM(category) Policy1,
NULLIF(TRIM(category),'') Policy2,
COALESCE(NULLIF(TRIM(category),''), 'unknown') Policy3
FROM dbo.temp_orders; 




-------------------------------------------------------------

/* -- CASE STATEMENT --
Evaluates a list of conditions and returns a value when the first condition is met 

#1 Use Case (Categroizing data)

Main purpose is Data Transformation 
-- derive new information 
    - create new columns based on existing data.

#2 Use Case (Mapping Values)
-- transform data from one form to another in order to make it more readable 
and usable for analytics

#3 Use Case (handling Nulls)

#4 Conditional Aggregation 
-- apply aggregate functions only on subsets of data that fulfill certain condition 
*/


/* sql task : 
generate a report showing the total sales for each category: 
- High: if the sales higher than 50 
- Medium: if the sales between 20 and 50 
- Low: if the sales equal or lower than 20

- sort the result from the lowest to highest
*/

SELECT 
    Sales_category,
    SUM(Sales) Total_sales
FROM(
    SELECT 
        Sales, 
        CASE 
            WHEN Sales >50 THEN 'High'   
            WHEN Sales > 20 THEN 'Medium'
            ELSE 'Low'
        END AS Sales_category
    FROM Sales.Orders
)T
GROUP BY Sales_category
ORDER BY 2 ASC



/*
Retrieve employee details with gender displayed as full text 
*/


SELECT 
    EmployeeID,
    FirstName,
    LastName, 
    CASE 
        WHEN Gender = 'M' THEN 'Male'
        WHEN Gender = 'F' THEN 'Female'
        ELSE 'Not Avaliable'
    END AS Gender_text
FROM Sales.Employees


/* Retrieve customer details with abbreviated country code*/



SELECT 
    CustomerID, 
    FirstName,
    LastName,
    CASE    
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA' THEN 'US'
        ELSE 'N/A'
    END Countryabb
FROM Sales.Customers


-- quick form 
SELECT 
    CustomerID, 
    FirstName,
    LastName,
    CASE Country 
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN 'US'
        ELSE 'N/A'
    END Countryabb
FROM Sales.Customers


/* find average scores for customers and treat nulls as 0
and additional provide details such customerid, lastname 
*/
 

SELECT 
    CustomerID, 
    LastName,
    score, 
    COALESCE(Score, 0) Scoreclean,
    AVG(score) over() avg_score,  
    AVG(COALESCE(Score, 0)) OVER() avg_score_clean
FROM Sales.Customers 




/* sql task : 
Count How many times each customer has made an order 
with sales greater than 30 */

SELECT  
    CustomerID,  
    COUNT(OrderID) Total_orders
FROM Sales.Orders
WHERE Sales >30
GROUP BY CustomerID