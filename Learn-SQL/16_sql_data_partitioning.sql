/* -- SQL Data Partitioning -- 
Techinque to divide Big table into smaller partitions 

Partitioning splits one logical table into multiple physical storage units based on the value of a column (the partition key)
but the table still looks and behaves like a single table to every query and every application. 

Why ? 
-If your query filters on the partition key, SQL Server can skip partitions entirely 
instead of scanning the whole table.

assume we have an order tables with million of transactions 
| order_id | | order_date | | quantity | | Sales | 

and your running this query 
"""
SELECT 
    * 
FROM Orders 
WHERE order_date <= "31-12-2025"
"""

DB engine Execution plans will be 
- full table scan , slow :( 
- use an index on date column

but there is a problem with indexes with big tables
- If we have a big table, that's means DB engine go and build a very big B tree index 
and having a big index, slow down operation like (updating, inserting and deleting)

You can rebuild/reorganize indexes on one partition instead of the whole table 
critical when the table is billions of rows and you can't afford a full index rebuild.

- So we use Partitioning to optimize the performance 
and partitions make the indexing more efficient HOW?
If you put an index on a partition table, each partition is gonna get it's own index 
and this means the size of index will be smaller and this will help alot with searching for data

- partitions will support parrallel processing 
-- so you can store your partitions in different server and this help in doing parallel data processing 


- Multi temperture storage 
-- Old partitions (low frequnecy access data) on cheap/slow disks, hot partitions (high frequency access data) on fast disks (via filegroups) 

*/


-- SQL partitioning process -- 

-- Step 1: Create a Partition Function 
-- Define the logic on how to divide your big table into partitions 
-- Based on Partition key like (date, region, city)
USE CarrefourOLTP; 


CREATE PARTITION FUNCTION PartitionByYear (DATE)
AS RANGE LEFT FOR VALUES ('2024-12-31', '2025-12-31', '2026-12-31')

-- query lists all existing parition function 
SELECT
    name,
    type, 
    type_desc,
    boundary_value_on_right
FROM sys.partition_functions 

-- Step 2: Create File Groups 
/*
What is Filegroup? 
Logical container for one or more data files to help organizing partitions

PRIMARY FG:
Default Fg where all objects of database is stored sot it is container for all datafiles.

*/

ALTER DATABASE CarrefourOLTP ADD FILEGROUP FG_2024
ALTER DATABASE CarrefourOLTP ADD FILEGROUP FG_2025
ALTER DATABASE CarrefourOLTP ADD FILEGROUP FG_2026
ALTER DATABASE CarrefourOLTP ADD FILEGROUP FG_2027


-- TO REMOVE FILEGROUP 
-- ALTER DATABASE CarrefourOLTP REMOVE FILEGROUP FG_2024; 


-- Each FileGroup has a data file, each data file has one partition

-- Step 3: Create Data Files 
/*
DATAFILES: Physical files on hard disk that store the actual data
.mdf file  >> master data file 
.ndf file  >> secondary data file 
*/

-- Data File to store 2024 partition
ALTER DATABASE CarrefourOLTP ADD FILE 
(
    NAME = P_2024 , -- LOGICAL NAME 
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\P_2024.ndf' -- Physical file 
) TO FILEGROUP FG_2024

-- Data File to store 2025 partition
ALTER DATABASE CarrefourOLTP ADD FILE 
(
    NAME = P_2025 , 
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\P_2025.ndf'
) TO FILEGROUP FG_2025

-- Data File to store 2026 partition

ALTER DATABASE CarrefourOLTP ADD FILE 
(
    NAME = P_2026 , 
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\P_2026.ndf'
) TO FILEGROUP FG_2026

-- Data File to store 2027 partition

ALTER DATABASE CarrefourOLTP ADD FILE 
(
    NAME = P_2027 , 
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\P_2027.ndf'
) TO FILEGROUP FG_2027






-- Step 4 : Create Partition Schema 
-- map partitions to related file group 
-- connect every thing together 


CREATE PARTITION SCHEME SchemePartitionByYear 
AS PARTITION  PartitionByYear
TO (FG_2024, FG_2025, FG_2026, FG_2027)


--NOTE:  3 Boundaries = 4 Partitions = 4 Filegroups 
--NOte: order is very important





-- the more robust approach used in real pipelines:
-- Step 5 : Create the partitioned table
CREATE TABLE transactions_partitioned 
(
    transaction_id INT NOT NULL, 
    transaction_dt DATE NOT NULL, 
    payment_method VARCHAR(20) NOT NULL, 
    total_gross_amount DECIMAL(12 , 2),
    total_discount DECIMAL(12,2),
    total_net_amount DECIMAL(12, 2),
    status VARCHAR(15),
    
) ON [SchemePartitionByYear](transaction_dt)

-- The clustered index — THIS is what's actually partitioned
CREATE CLUSTERED INDEX IX_TRANSACTIONS_dt
ON transactions_partitioned(transaction_dt, transaction_id)
ON SchemePartitionByYear(transaction_dt)


-- now migrate the data 
INSERT INTO transactions_partitioned
SELECT
    transaction_id,
    transaction_dt,
    payment_method, 
    total_gross_amount,
    total_discount,
    total_net_amount,
    [status]
FROM CarrefourOLTP.dbo.transactions



-- Check and testing 
SELECT 
    p.partition_number,
    f.name AS FileGroupName,
    p.[rows] As NumOfROws 
FROM sys.partitions p 
JOIN sys.destination_data_spaces dds 
ON P.partition_number = dds.destination_id 
JOIN sys.filegroups F 
ON F.data_space_id = dds.data_space_id 
WHERE OBJECT_NAME(P.object_id) ='transactions_partitioned'



-- 