USE salesdb; 

/* -- DateTime Functions --
--  Part Extraction 
    - DAY
    - MONTH
    - YEAR 
    - DATEPART
    - DATENAME
    - DATETRUNC
    - EOMONTH


--  Format & Casting     
    - FORMAT
    - CONVERT
    - CAST


--  Calculations 
    - DATEADD
    - DATEDIFF 

--  Validation 
    - ISDATE
*/

SELECT 
    OrderDate, 
    ShipDate, 
    CreationTime,
    GETDATE() Today,
    '2025-08-2' Hardcoded

FROM Sales.Orders


-- Part Extraction functions 

SELECT 
    OrderID,
    CreationTime,
    YEAR(CreationTime) Year,
    MONTH(CreationTime) Month,
    DAY(CreationTime) Day
FROM Sales.Orders



-- DATEPART FUNCTION  (Returns a specific part of a date as a number.)
-- the output of this function is a integer
SELECT 
    CreationTime,
    DATEPART(DAY, CreationTime) day_dp,
    DATEPART(MONTH, CreationTime) month_dp,
    DATEPART(YEAR, CreationTime) year_dp,
    DATEPART(HOUR, CreationTime) hour_dp,
    DATEPART(QUARTER, CreationTime) quarter_dp,
    DATEPART(WEEKDAY, CreationTime) WEEKDAY_dp,
    DATEPART(WEEK, CreationTime) WEEK_dp
FROM Sales.Orders


-- DATENAME FUNCTION  (Returns The name of specific part of a date.)
-- the output of this fuction is a string 
SELECT 
    CreationTime,
    DATENAME(DAY, CreationTime) day_dn,
    DATENAME(MONTH, CreationTime) month_dn,
    DATENAME(WEEKDAY, CreationTime) WEEKDAY_dn
FROM Sales.Orders



-- DATETRUNC FUNCTION  (Truncates the date to the specific part.)

SELECT 
    CreationTime, 
    DATETRUNC(MINUTE, CreationTime) minute_tr,
    DATETRUNC(DAY, CreationTime) day_tr,
    DATETRUNC(MONTH, Creationtime) month_tr,
    DATETRUNC(YEAR, CreationTime) Year_tr
FROM Sales.Orders


-- USE CASE 
SELECT 
    DATETRUNC(MONTH, CreationTime) creation, 
    COUNT(*) Total_orders
FROM Sales.Orders
GROUP by DATETRUNC(MONTH, CreationTime)



-- EOMONTH  (Return the last day of a month)

SELECT EOMONTH(GETDATE())

SELECT 
    OrderID,
    CreationTime, 
    EOMONTH(CreationTime) EndOfMonth,
    CAST(DATETRUNC(MONTH, CreationTime) AS DATE)  StartOfMonth
FROM Sales.Orders


-- Part Extraction USE CASES (Data Aggregation)

-- How many orders were placed each MONTH?

SELECT 
    DATENAME(MONTH, OrderDate) Month,
    COUNT(*) number_of_orders
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate);



-- Filtering Data 

/* show all orders that were placed during the month of february)*/

SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

-- NOTE (Filtering data using an integer is faster than using a string.)

-----------------------------------------------------------------------

/* Datetime Format & Casting Fucntions
-- FORMAT 
-- CONVERT 
-- CAST */


SELECT 
    OrderID,
    CreationTime, 
    FORMAT(CreationTime, 'dd')  dd,
    FORMAT(CreationTime, 'ddd')  ddd,
    FORMAT(CreationTime, 'dddd')  dddd,
    FORMAT(CreationTime, 'MM')  MM,
    FORMAT(CreationTime, 'MMM')  MMMM,
    FORMAT(CreationTime, 'MMMM')  MMMM
FROM Sales.Orders


SELECT 
    OrderID, 
    CreationTime,
    FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
    FORMAT(CreationTime, 'dd-MM-yyyy') EUR_Format
FROM Sales.Orders


/* sql task:
Show creationtime using the following format
day wed Jan Q1 2025 12:34:56 */

SELECT
    OrderID,
    CreationTime, 
    'Day ' +FORMAT(CreationTime, 'ddd MMM') +
    ' Q'+ DATENAME(QUARTER, CreationTime) +
    ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt')
FROM Sales.Orders




-- sales per month 

SELECT 
    FORMAT(OrderDate, 'MMM yy') orderdate,
    SUM(Sales) Total_sales
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy')


-- CONVERT FUNCTION 
SELECT 
CONVERT(INT, '123') string_to_int,
CONVERT(date, '2025-08-20') string_to_date,
CONVERT(datetime,CONVERT(date, '2025-08-20')) date_to_datetime



SELECT 
    OrderID, 
    CreationTime, 
    CONVERT(varchar, CreationTime, 32) as [USA Std. style:32],
    CONVERT(varchar, CreationTime, 34) as [EURO Std. style:34]
FROM Sales.Orders




/* 
 
--use case in date cleanup by formatting different formats--
Cast/convert string → date first, then apply FORMAT.
----------------------------------------------------------
If i ingest data from different sources and each source 
produce the date in a different form 
and you want to make a standard format for all these dates 
csv file --- > 20/08/2025
api ---> 20.08.2025
DB ---> 20 Aug 2025 
*/
SELECT FORMAT(CONVERT(datetime, '20/08/2025', 103), 'yyyy-MM-dd')
SELECT FORMAT(CONVERT(datetime, '20.08.2025', 103), 'yyyy-MM-dd') 
SELECT FORMAT(CONVERT(datetime, '20 Aug 2025' , 103), 'yyyy-MM-dd') 

-- 103 = British/French style (dd/MM/yyyy).




-- CAST FUNCTION 

SELECT
    CAST('123' AS INT) AS [string to int],
    CAST('2025-08-20' AS date) AS [string to date],
    CAST('2025-08-20' AS datetime) AS [string to datetime],
    CreationTime,
    CAST(CreationTime as date)  as [datetime to date]
FROM Sales.Orders



/* DATETIME Calculations Functions
-- DATEADD FUNC (adds or subtracts a specific time interval to / from a date)
-- DATEDIFF FUNC (find the difference between two dates.)
*/


-- DATEADD FUCNTION 
SELECT  
    OrderID,
    OrderDate,
    DATEADD(DAY, -10, orderdate) TenDaysBefore,
    DATEADD(MONTH, 3, OrderDate) ThreeMonthsLater, 
    DATEADD(YEAR, 2, OrderDate) AS [TwoYearsLater]
FROM Sales.Orders



-- DATEDIFF

SELECT 
    OrderDate, 
    ShipDate,
    DATEDIFF(DAY, OrderDate, ShipDate)
FROM Sales.Orders

-- SQL Tasks : 

-- calculate the age of employees

SELECT 
    FirstName, 
    DATEDIFF(YEAR, BirthDate, GETDATE()) Age
FROM Sales.Employees 


-- Find the average shipping duration in days for each month 
SELECT
    DATENAME(MONTH, OrderDate) Month,
    AVG(DATEDIFF(DAY, OrderDate, ShipDate)) as [avg shipping duration]
FROM Sales.Orders
GROUP BY DATENAME(MONTH, OrderDate)


-- Time Gap Analysisv (LAG WINDOW FUCTION, DATEDIFF FUNCTION)
-- Find the number of days between each order and previous order

SELECT
OrderID, 
OrderDate CurrentOrderDate,
LAG(OrderDate) OVER(ORDER by OrderDate) PreviousOrderDate,
DATEDIFF(DAY,LAG(OrderDate) OVER(ORDER by OrderDate), OrderDate) number_of_days
FROM Sales.Orders



-- ISDATE FUNC (Check if a value is a date )
SELECT 
ISDATE('2025-08-20') datechk1, 
ISDATE('2025/08/20') datechk2,
ISDATE('20-08-2025') datechk3

-- use case on isdate function 
-- VALIDATION CHECK 

SELECT 
    Orderdate, 
    ISDATE(Orderdate),
    CASE WHEN ISDATE(Orderdate) = 1 THEN CAST(Orderdate AS DATE)
    ELSE CAST(GETDATE() AS DATE)
    END NewOrderDate
FROM (
    SELECT '2025-08-20' AS Orderdate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION 
    SELECT '2025-08'
)T
-- WHERE  ISDATE(Orderdate) =0
