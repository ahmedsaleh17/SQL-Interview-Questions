-- switch database 
USE CarrefourOLTP ; 
-- USE TestDB;


-- List all indexes on a specific table 
-- Display indexes information by using a special stored procedures 

sp_helpindex 'transactions' 

/*
-- Monitoring Index Usage --
	- Sys System Schema 
	   contains metadata about database tables, views, indexes 

	- Dynamic Management View (DMV)
		provides real-time insights about DataBase performance and system health 
*/


SELECT
	TAB.name AS TableName, 
	IDX.name AS IndexName, 
	IDX.type_desc AS IndexType, 
	IDX.is_unique AS IsUnique, 
	IDX.is_primary_key AS IsPrimary,
	STAT.user_scans AS UserScans, 
	STAT.user_seeks AS UserSeeds, 
	STAT.user_lookups AS UserLookUps, 
	STAT.user_updates AS UserUpdates, 
	COALESCE(STAT.last_user_seek, STAT.last_user_scan) AS LastUpdate

FROM sys.indexes IDX 
JOIN sys.tables TAB
ON IDX.object_id = TAB.object_id
LEFT JOIN sys.dm_db_index_usage_stats STAT
ON STAT.object_id = IDX.object_id 
AND STAT.index_id = IDX.index_id
ORDER BY TableName, IndexName



-- Monitor Missing Indexes -- 
SELECT 
	*
FROM sys.dm_db_missing_index_details


-- Monitor Duplicate Indexes 

-- If you collobrate to optimize the DB Performance 
-- May be different developers creating different indexes for the same column 


SELECT
	tab.name AS TableName,
	cols.name AS ColName,
	idx.name AS IndexName, 
	idx.type_desc AS IndexType,
	COUNT(*) OVER (PARTITION BY tab.name, cols.name) AS ColumnCount
FROM sys.indexes idx
JOIN sys.tables tab 
ON idx.object_id = tab.object_id 
JOIN sys.index_columns idxcol 
ON idx.object_id = idxcol.object_id
   AND idx.index_id = idxcol.index_id
JOIN sys.columns cols 
ON idx.object_id = cols.object_id 
   AND idxcol.column_id = cols.column_id
    
ORDER BY  ColumnCount DESC




-- Monitor and Update Statistics --
/* The DataBase Engine usually use statistics in order to understand which index should be used 
for our query and if these statistics are not up-to-date db engine are gonna make wrong desisions 

when db engine query data from table, there are different ways of scan 
- table scan 
- index scan 
- index seek 

and in order for database to decide which method used to load data, it gonna go and read the stats of the table.

*/


SELECT
	SCHEMA_NAME(t.schema_id) AS SchemaName, 
	t.name AS TableName, 
	s.name AS StatName, 
	sp.last_updated AS LastUpdate, 
	DATEDIFF(day, sp.last_updated, GETDATE()) as LastUpdateDay, 
	sp.rows AS Rows, 
	sp.modification_counter AS ModificationSinceLastUpdate

FROM sys.stats AS s 
JOIN sys.tables AS t
ON s.object_id = t.object_id 
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS Sp
ORDER BY last_updated DESC


-- udpate specific statistics 

UPDATE STATISTICS transactions  ix_transactions_customer; 



-- udpate all statistics in a table 
UPDATE STATISTICS transactions 


-- udpate all statistics in a database 

EXEC sp_updatestats

/* updating statistics methodology : 
1- weekly job to update statistics on weekends 
2- after migrating data */






/* 
What is Fragmentation ?
- Unused spaces in data pages 
- Data pages are out of order 
and this leads to inefficient use of the storage and as well as gonna slow down your queries 


Fragmentation Methods: 

- Reorganize: Defragment leaf nodes to keep them sorted (light operation)
if avg_fragmentation_in_percent between 10% - 30%

- Rebuild: Recreate index from scratch (heavy operation)
if avg_fragmentation_in_percent greater than 30%

*/


-- How to find any fragmentations issues in our indexes ?
-- we need to check the health of our indexes in the database


SELECT 
	tab.name TableName,
	idx.name IndexName, 
	stats.avg_fragmentation_in_percent 
FROM sys.dm_db_index_physical_stats(DB_ID(), null, null, null, 'LIMITED') AS stats 
JOIN sys.indexes AS  idx
ON idx.object_id = stats.object_id 
and idx.index_id = stats.index_id
JOIN sys.tables as tab 
on tab.object_id = idx.object_id
ORDER BY stats.avg_fragmentation_in_percent DESC

/* avg_fragmentation_in_percent 
indicate how out-of-order pages are with in the index 
- 0%  means no fragmentation (perfect)
- 100 % means index is completely fragmented(out of order)

When To Defragment?
- < 10%  no action needed 
- 10 - 30 % Reorganize
- > 30% Rebuild
*/


-- How to Reorganize 

ALTER INDEX Idx_transactions_branch_dt 
ON transactions  REORGANIZE


-- How to Rebuild

ALTER INDEX ix_transactions_branch_dt 
ON transactions  REBUILD

ALTER INDEX ix_transaction_items_product 
ON transaction_items REBUILD




-- So, Improving the performance of queries doesn't end with creating Indexes 
-- it's all about staying proactive so Monitor the usage of indexes, check missing indexes and make sure the statistics of database are always updated
