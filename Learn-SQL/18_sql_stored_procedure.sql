/* 
What is stored procedure ? 
- precompiled batch of SQL statements stored inside the database itself, 
which you can execute by calling its name instead of rewriting the SQL every time.


Why you need it — the core reasons? 
- Code Reusability - The same procedure can be called from various applications

- Improved Performance - Stored procedures are precompiled and runs faster
SQL Server compiles and caches an execution plan for a stored procedure the first time it runs, 
then reuses that plan on subsequent calls (as long as parameters/stats don't change).

- Database Security - You can grant a user/application permission to execute a procedure 
without granting them direct SELECT/INSERT/UPDATE rights on the underlying tables

-Reduced network traffic

One EXEC procedure_name @param1, @param2 call replaces sending potentially hundreds of lines of SQL scripts 
over the network on every single call — matters at scale, especially from application layers.


- Easy Maintenance - When updating a procedure, it automatically updates all its use



-- Procedure Syntax 

CREATE PROCEDURE ProcedureName AS 
BEGIN  

-- SQL STATEMNETS 

END 

*/





-- For US Customers Find the Total Number of customers and the average score 

USE SalesDB ; 



SELECT 
    COUNT(*) TotalCustomers, 
    AVG(Score) AvgScore 
FROM Sales.Customers
WHERE Country = 'USA'

-- let's say we have alot of reports use the same previous query, 
-- and i want to use the power of SP to optimize of the performance 


CREATE PROCEDURE GetCustomerSummary AS 
BEGIN 

    SELECT 
        COUNT(*) TotalCustomers, 
        AVG(Score) AvgScore 
    FROM Sales.Customers
    WHERE Country = 'USA'

END



-- execute the procedure 
EXEC GetCustomerSummary; 




/* SP Parameters: 
-- placeholders used to pass values as input from the caller to the procedure, 
allowing dynamic data  to be processed


-- to avoid repetition of the same logic in multiple stored procedure 
so the power of using parameters make the stored procedure more reusable and dynamic 
*/


ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) AS 
BEGIN 

    SELECT 
        COUNT(*) TotalCustomers, 
        AVG(Score) AvgScore 
    FROM Sales.Customers
    WHERE Country = @Country

END

 


-- execute the procedure 
EXEC GetCustomerSummary @Country='USA';
EXEC GetCustomerSummary @Country='Germany'; 

---------------------------------------------------------------------------


/* let's say we are usually execute the stored procedure by using USA and I want to make the USA as Default */


ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS 
BEGIN 

    SELECT 
        COUNT(*) TotalCustomers, 
        AVG(Score) AvgScore 
    FROM Sales.Customers
    WHERE Country = @Country

END



-- execute the procedure 
EXEC GetCustomerSummary ; -- USA 
EXEC GetCustomerSummary @Country='Germany'; 


-------------------------------------------------------------

-- Multiple of SQL queries in the same SP  


ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS 
BEGIN 

    SELECT 
        COUNT(*) TotalCustomers, 
        AVG(Score) AvgScore 
    FROM Sales.Customers
    WHERE Country = @Country;
    
    
    -- Find the Total Nr. of order and total sales for each country 

    SELECT 
        COUNT(OrderID) TotalOrders, 
        SUM(Sales) TotalSales
    FROM Sales.Orders O   
    JOIN Sales.Customers C   
    ON O.CustomerID = C.CustomerID 
    WHERE c.Country  = @Country;

END




-- execute the procedure 
EXEC GetCustomerSummary ; -- USA 
EXEC GetCustomerSummary @Country='Germany'; 



---------------------------------------------------------------------------------


-- Stored Procedure Variables 
-- Variable temporarily store and manipulate data during it's execution 



ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS 
BEGIN 

    DECLARE @TotalCustomers INT, @AverageScore FLOAT, @TotalOrders INT, @TotalSales INT; 

    -- generating report
    SELECT 
        @TotalCustomers= COUNT(*) , 
        @AverageScore =  AVG(Score)  
    FROM Sales.Customers
    WHERE Country = @Country;
    
    PRINT 'Total customers from ' +  @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR);
    PRINT 'Average Score from ' +  @Country + ': ' + CAST(@AverageScore AS NVARCHAR);

    PRINT '------------------------------------------------------------------------';


    -- Find the Total Nr. of order and total sales for each country 

    SELECT 
        @TotalOrders =  COUNT(OrderID) , 
        @TotalSales = SUM(Sales) 
    FROM Sales.Orders O   
    JOIN Sales.Customers C   
    ON O.CustomerID = C.CustomerID 
    WHERE c.Country  = @Country;

    PRINT 'Total Orders from ' + @Country + ': ' + CAST(@TotalOrders AS NVARCHAR); 
    PRINT 'Total Sales from ' + @Country + ': ' + CAST(@TotalSales AS NVARCHAR); 

END


-- execute the procedure 
EXEC GetCustomerSummary ; -- USA 
EXEC GetCustomerSummary @Country='Germany'; 



---------------------------------------------------------------------

-- Stored Procedure - Control Flow 


ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS 
BEGIN 

    DECLARE @TotalCustomers INT, @AverageScore FLOAT, @TotalOrders INT, @TotalSales INT; 

    -- CleanUp data     

    IF EXISTS (SELECT 1 from Sales.Customers WHERE Score IS NULL and Country = @Country)
    BEGIN 
        PRINT ('Ubdating Null Scores to zero');
       
        UPDATE Sales.Customers 
        SET SCORE = 0 
        WHERE Score IS NULL AND Country = @Country;
    END 

    ELSE 
    BEGIN 
        PRINT('No Null scores found')
    END;


    -- generating report
    SELECT 
        @TotalCustomers= COUNT(*) , 
        @AverageScore =  AVG(Score)  
    FROM Sales.Customers
    WHERE Country = @Country;
    
    PRINT 'Total customers from ' +  @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR);
    PRINT 'Average Score from ' +  @Country + ': ' + CAST(@AverageScore AS NVARCHAR);

    PRINT '------------------------------------------------------------------------';


    -- Find the Total Nr. of order and total sales for each country 

    SELECT 
        @TotalOrders =  COUNT(OrderID) , 
        @TotalSales = SUM(Sales) 
    FROM Sales.Orders O   
    JOIN Sales.Customers C   
    ON O.CustomerID = C.CustomerID 
    WHERE c.Country  = @Country;

    PRINT 'Total Orders from ' + @Country + ': ' + CAST(@TotalOrders AS NVARCHAR); 
    PRINT 'Total Sales from ' + @Country + ': ' + CAST(@TotalSales AS NVARCHAR); 

END


-- execute the procedure 
EXEC GetCustomerSummary ; -- USA 
EXEC GetCustomerSummary @Country='Germany'; 






-- Stored Procedure - Error Handling 




ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA' AS 
BEGIN 

BEGIN TRY

    DECLARE @TotalCustomers INT, @AverageScore FLOAT, @TotalOrders INT, @TotalSales INT; 
    
    -- ============================
    -- CleanUp data     
    -- ============================

    IF EXISTS (SELECT 1 from Sales.Customers WHERE Score IS NULL and Country = @Country)
    BEGIN 
        PRINT ('Ubdating Null Scores to zero');
       
        UPDATE Sales.Customers 
        SET SCORE = 0 
        WHERE Score IS NULL AND Country = @Country;
    END 

    ELSE 
    BEGIN 
        PRINT('No Null scores found')
    END;


    -- =====================================
    -- generating report
    -- =====================================


    SELECT 
        @TotalCustomers= COUNT(*) , 
        @AverageScore =  AVG(Score)  
    FROM Sales.Customers
    WHERE Country = @Country;
    
    PRINT 'Total customers from ' +  @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR);
    PRINT 'Average Score from ' +  @Country + ': ' + CAST(@AverageScore AS NVARCHAR);

    PRINT '------------------------------------------------------------------------';


    -- Find the Total Nr. of order and total sales for each country 

    SELECT 
        @TotalOrders =  COUNT(OrderID) , 
        @TotalSales = SUM(Sales) 
    FROM Sales.Orders O   
    JOIN Sales.Customers C   
    ON O.CustomerID = C.CustomerID 
    WHERE c.Country  = @Country;

    PRINT 'Total Orders from ' + @Country + ': ' + CAST(@TotalOrders AS NVARCHAR); 
    PRINT 'Total Sales from ' + @Country + ': ' + CAST(@TotalSales AS NVARCHAR); 


    SELECT 
        OrderID,
        OrderDate,
        1/0
    FROM Sales.Orders

END TRY 

BEGIN CATCH 
    -- =============================
    -- Error handling 
    -- ============================
    PRINT('An error occured.');
    PRINT('Erorr Message:'+ ERROR_MESSAGE());
    PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
    PRINT('Error LINE: ' + CAST(ERROR_LINE() AS NVARCHAR));
    PRINT('Error Procedure'+ ERROR_PROCEDURE());

END CATCH

END


-- execute the procedure 
EXEC GetCustomerSummary ; -- USA 
EXEC GetCustomerSummary @Country='Germany'; 
