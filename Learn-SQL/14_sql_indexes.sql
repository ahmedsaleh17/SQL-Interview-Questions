-- clustered & nonclustered indexes: 
USE SalesDB;

SELECT
    *
FROM Sales.Customers
-- this table have a defult clustered index because of Primary key

-- CREATE A NEW TABLE WITHOUT ANY INDEXES: 
-- BY loading the customers table into a new table
SELECT 
    *
INTO sales.DBCustomers
FROM SALES.Customers


-- now search from the new table 

SELECT 
    *
FROM Sales.DBCustomers
WHERE CustomerID = 3 
-- To find the customer with id 3 the db engine full scans all table 



-- create new clustered index 

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers(CustomerID)



-- delete index
DROP INDEX idx_DBCustomers_CustomerID 
ON Sales.DBCustomers;


SELECT
    *
FROM Sales.DBCustomers
WHERE LastName = 'Brown'

-- To improve the performance of the previous query because you use alot
-- you can create non clustered index


CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName 
ON Sales.DBCustomers(LastName)


-- composite Index
SELECT
    *
FROM SALES.DBCustomers
WHERE Country = 'USA' AND Score > 500

-- WHAT IF YOU USE THE PREVIOUS QUERY ALOT 
-- AND YOU NEED TO IMPROVE PERFORMANCE OF THE PREVIOUS QUERY
CREATE INDEX idx_DBCustomers_CountryScore 
ON Sales.DBCustomers(Country, Score) 
-- Rule : the columns of index order must match the order in yyour query
-- THE ORDER OF COLUMNS IN QUERY MUST BE THE SAME IN THE NON CLUSTERED INDEX


/* Leftmost Prefix Rule 
index works only if your query filters start from 
the first column in the index and follow it's order*/


--so this query will use the index 
SELECT
    *
FROM Sales.DBCustomers 
WHERE Country = 'USA'


-- BUT This Query doesn't Use the index 
SELECT
    *
FROM Sales.DBCustomers 
WHERE Score  > 500


/* anthor example to understand leftmost prefix rule
index (A, B, C, D)

-- index will be used if filters like that 
A
A, B
A, B, C

-- index will not be used 
B
B, C 
B, A 
A, C 
A, B, D 
*/



------------------------------------------

-- columnstore index syntax
/*
CREATE [CLUSTERED | NONCLUSTERED] [COLUMNSTORE | ROWSTORE(DEFAULT)] INDEX  index_name
ON TABLE_NAME(COLUMN1, COLUMN2)

EX: 

-- ROWSTORE index
CREATE CLUSTERED INDEX idx_Customers_ID ON Customers(ID)
CREATE NONCLUSTERED INDEX IDX_Customers_country ON Customers(Country)

-- COLUMNSTORE index 
CREATE CLUSTERED COLUMNSTORE INDEX idx_Customers ON Customers
CREATE NONCLUSTERED COLUMNSTORE INDEX IDX_Customers_country ON Customers(Country)

RULE: you can't specify columns in clustered columnstore index
RULE: the table have only one column store index either clustered or nonclustered

*/



-- let's make our table splitted by columns 
-- but first we need to remove the existed clustered index 
DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;
CREATE CLUSTERED COLUMNSTORE INDEX Idx_DBCustomers ON SALES.DBCustomers



----------------------------------------------------------

-- creating 3 copies of table with different structure
USE AdventureWorksDW2022;


-- heap structure 
SELECT
    *
INTO FactInternetSales_HP
FROM FactInternetSales


-- clustered rowstore index
SELECT
    *
INTO FactInternetSales_RS
FROM FactInternetSales


CREATE CLUSTERED INDEX IDX_FactInternetSales_RS_PK
ON FactInternetSales_RS(SalesOrderNumber, SalesOrderLineNumber)

-- clustered cloumnstore index
SELECT
    *
INTO FactInternetSales_CS
FROM FactInternetSales


CREATE CLUSTERED COLUMNSTORE INDEX IDX_FactInternetSales_CS_PK
ON FactInternetSales_CS



-- Display Estimated Execution Plan


SELECT -- TABLE FULL SCAN
    *
FROM FactInternetSales_HP



SELECT    -- CLUSTERED INDEX SCAN
	*
FROM FactInternetSales_RS


SELECT   -- COLUMNSTORE INDEX SCAN
	*
FROM FactInternetSales_CS


-----------------------------------------
USE SalesDB;
-- Unique index 
SELECT 
    *
FROM Sales.Products

--DEFINE AN UNIQUE INDEX FOR PRODUCT NAME 
CREATE UNIQUE NONCLUSTERED INDEX IDX_Products_unique
ON Sales.Products(Product)

-- try to insert an existing product 

INSERT INTO Sales.Products
VALUES
(106, 'Tire', 'Accessories', 20)
/* error: 
Cannot insert duplicate key row in object 'Sales.Products' 
with unique index 'IDX_Products_unique'. The duplicate key value is (Tire).
*/



---------------------------------------------------------
--  