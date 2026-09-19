/* ===Transactions - ACID properties=== 
Transactions in SQL Server
A transaction is a group of SQL operations that treated as one logical unit of work.

Either all operations succeed, or none of them should be applied.

              BEGIN
                │
                ▼
          BEGIN TRANSACTION
                │
        ┌───────┴────────┐
        │                │
      Success           Error
        │                │
        ▼                ▼
     COMMIT           ROLLBACK
        │                │
        ▼                ▼
     Finished          THROW


ACID Properties : 

| Property        | Meaning                                            |
| --------------- | -------------------------------------------------- |
| **Atomicity**   | All operations happen, or none happen              |
| **Consistency** | Database rules remain valid                        |
| **Isolation**   | Concurrent transactions don't improperly interfere |
| **Durability**  | Committed changes survive failures                 |




The Big Picture:
Application
    │
    │ SQL statements
    ▼
SQL Server Engine
    │
    ├── Transaction Manager
    │
    ├── Lock Manager
    │
    ├── Buffer Pool
    │
    └── Transaction Log
             │
             ▼
          Disk (.ldf)

A common misconception is:

"SQL Server changes the table on disk and then commits."

That's not really how you should think about it.

SQL Server uses a write-ahead logging (WAL) strategy.

SQL Statement
     ↓
Buffer Pool (memory)
     ↓
Modify data page
     ↓
Write transaction log (.ldf)
     ↓
COMMIT
     ↓
Log becomes durable
     ↓
Locks released
     ↓
Data page can be written to .mdf later


| Component                  | Purpose                                             |
| -------------------------- | --------------------------------------------------- |
| **Transaction**            | Groups operations into one unit                     |
| **Buffer Pool**            | Holds data pages in memory                          |
| **Transaction Log (.ldf)** | Records changes for durability/recovery             |
| **Locks**                  | Protect data from conflicting concurrent operations |
| **COMMIT**                 | Make transaction permanent                          |
| **ROLLBACK**               | Undo transaction changes                            |
| **Recovery**               | Uses the log after a crash                          |



The key concept

SQL Server uses Write-Ahead Logging (WAL):

The log must be safely written before the modified data page is written to disk.


*/
USE TestDB; 


-- Creating the table
CREATE TABLE Accounts(
	AccountID INT PRIMARY KEY, 
	AccountName VARCHAR(25),
	Balance DECIMAL(10, 2)
)

-- Insert sample data 

INSERT INTO Accounts 
VALUES 
(1, 'Ahmed', 10000.0),
(2, 'Mariam', 5000.0),
(3, 'Ali', 1000.0)

-- check 
SELECT * FROM Accounts;

-- transactions  - auto commit 
UPDATE Accounts 
SET Balance = 15000 
WHERE AccountID = 3


-- To disable auto commit 
SET IMPLICIT_TRANSACTIONS ON ; 

UPDATE Accounts 
SET Balance = 12000 
WHERE AccountID = 3;

/* NOTICE : If you disable auto commit, this means you can't do any operation on this table 
without commit transactions, because db engine lock the table until trancations be commited 

after the transaction commited, the lock release and you can do any operation (select - update - delete - insert)*/

COMMIT; 

-- to enable auto commit  
SET IMPLICIT_TRANSACTIONS OFF ; 

UPDATE Accounts 
SET Balance = 9000 
WHERE AccountID = 3;


-- BEGIN TRANSACTION STATEMENT 

-- Let's transfer $200 from Ahmed to Mariam: 
BEGIN TRANSACTION; 

UPDATE Accounts 
SET Balance = Balance - 200
WHERE AccountID =1; 

UPDATE Accounts 
SET Balance= Balance+200 
WHERE AccountID = 2;

COMMIT TRANSACTION; 



-- Now transfer $100 from Mariam to Ali, but don't commit:

BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 2;

UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 3;

SELECT *
FROM Accounts;

ROLLBACK TRANSACTION;


SELECT *
FROM Accounts;



/*
1. BEGIN TRANSACTION
       ↓
   SQL Server creates/starts
   a transaction context
       ↓
2. UPDATE
       ↓
   Data page is loaded into
   the Buffer Pool (memory)
       ↓
3. SQL Server modifies
   the page in memory
       ↓
4. Transaction Log (.ldf)
       ↓
   SQL Server records the change
   in the transaction log
       ↓
5. COMMIT
       ↓
   Required log records are
   made durable
       ↓
6. Transaction = COMMITTED
       ↓
   Locks are released
       ↓
7. Dirty data page can later
   be written to the .mdf



- Atomicity - each statement in a transaction (to read, write, update or delete data) is treated as a single unit. Either the entire statement is executed, or none of it is executed. 
	This property prevents data loss and corruption from occurring if, for example, if your streaming data source fails mid-stream.

- Consistency - ensures that transactions only make changes to tables in predefined, predictable ways. 
	Transactional consistency ensures that corruption or errors in your data do not create unintended consequences for the integrity of your table.

- Isolation - when multiple users are reading and writing from the same table all at once, isolation of their transactions ensures that the concurrent transactions don't interfere with or affect one another. 
	Each request can occur as though they were occurring one by one, even though they're actually occurring simultaneously.

- Durability - ensures that changes to your data made by successfully executed transactions will be saved, even in the event of system failure.

*/





