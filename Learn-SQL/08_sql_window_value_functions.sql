-- value window functions 
-- used to access a value from another row
/* 
- LAG()
- LEAD()
- FIRST_VALUE() 
- LAST_VALUE() 
*/ 


USE salesDb; 

-- Month-Over-Month analysis |  UseCase 

/*SQL TASK: 
Analyze the month-over-month (MOM) Performance 
by finding the percentage change in sales 
between the current and previous month*/

SELECT 
    [month],
    CurrentMonthSales - PreviousMonthSales MOM_Change,
    ROUND( CAST((CurrentMonthSales - PreviousMonthSales) AS float) / PreviousMonthSales *100, 1)  MOM_Percentage
FROM 
(
    SELECT 
        DATEPART(MONTH, OrderDate) month, 
        SUM(Sales) CurrentMonthSales,
        LAG(SUM(Sales)) OVER(ORDER by DATEPART(MONTH, OrderDate) ASC ) PreviousMonthSales
    FROM Sales.Orders 
    GROUP BY DATEPART(MONTH, OrderDate)

)T



/* Customer Rentention Analysis | use case: 
Measure customer's behavior and loyalty to help 
businesses bulid strong relationships with customers.*/


/* SQL Task: 
Analyze customer loyalty by ranking customers 
based on the average number of days between orders */


SELECT
CustomerID, 
AVG(NrOfDays) AvgDays,
ROW_NUMBER() OVER(ORDER by AVG(NrOfDays) ASC) 
FROM (

    SELECT 
        CustomerID, 
        OrderDate CurrentOrderDate,
        LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate ASC) Nextorderdate,
        DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate ASC)) NrOfDays
    FROM Sales.Orders
)T
GROUP by CustomerID ; 





-- FIRST_VALUE & LAST_VALUE FUNCTION 

/*SQL TASK: 
Find the lowest and highest sales for each product */


SELECT 
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY SALES) LowestSales,
    LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY SALES 
     RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales
FROM Sales.Orders 