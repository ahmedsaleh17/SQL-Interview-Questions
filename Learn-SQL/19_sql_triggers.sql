/*  
what is trigger ? 
-- special type of stored procedure that automatically fires (executes) in response to  
an event on a table or view 

Types of triggers in SQL Server

- DML Trigger	INSERT / UPDATE / DELETE on a table/view	
    Auditing, enforcing business rules, cascading logic

- DDL Trigger	CREATE / ALTER / DROP (schema changes)	
    Preventing/logging schema changes

- Logon Trigger	User logon event	
    Restricting logins, connection auditing



-- DML Triggers (AFTER, INSTEAD OF)

- AFTER (runs after event)
- INSTEAD OF (runs during event)



*/



-- Trigger Use Case (Mainting and auditing logs)

-- Use the target database for the example
USE SalesDB; 


-- Step 1: Create a log table to store trigger activity
CREATE TABLE sales.employeesLogs 
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT, 
    LogMessage VARCHAR(255),
    LogDate DATETIME
)


-- Step 2: Create an AFTER INSERT trigger
-- This trigger automatically logs every new employee inserted into the Employees table
CREATE TRIGGER trg_after_insert_emgloyee ON Sales.Employees 
AFTER INSERT 
AS 
BEGIN
    -- Insert a record into the audit log for each new row in the inserted table
    INSERT INTO Sales.employeesLogs (EmployeeID, LogMessage, LogDate)
    SELECT 
        EmployeeID, 
        'New Employee Added : ' + CAST(EmployeeID as varchar),
        GETDATE()
    FROM inserted
END



-- Step 3: Fire the trigger by inserting sample data
-- Whenever data is inserted into Employees, the trigger will run automatically

INSERT INTO Sales.Employees 
VALUES 
(6, 'Ahmed', 'saleh', 'Data Engineering', '2000-04-09', 'M', 50000, Null)


INSERT INTO Sales.Employees 
VALUES 
(7, 'Mari', 'jake', 'Finance', '1999-04-09', 'F', 45000, Null)




-- Step 4: Check the audit log table to verify the trigger worked
SELECT 
    *
FROM Sales.employeesLogs