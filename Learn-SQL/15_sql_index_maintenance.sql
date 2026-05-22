-- switch database 
--USE CarrefourOLTP ; 
USE TestDB;


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




-- Update Statistics -- 

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
ORDER BY ModificationSinceLastUpdate


-- udpate specific statistics 

UPDATE STATISTICS transactions  _WA_Sys_00000001_48CFD27E; 



-- udpate all statistics in a table 
UPDATE STATISTICS transactions 


-- udpate all statistics in a database 

EXEC sp_updatestats



 

/* Fragmentation Methods: 

- Reorganize: Defragment leaf nodes to keep them sorted
if avg_fragmentation_in_percent between 10% - 30%

- Rebuild: Recreate index from scratch 
if avg_fragmentation_in_percent greater than 30%

*/

-- How to Reorganize 

ALTER INDEX Idx_transactions_branch_dt 
ON transactions  REORGANIZE


-- How to Rebuild

ALTER INDEX Idx_transactions_branch_dt 
ON transactions  REBUILD


-- So, Improving the performance of queries doesn't end with creating Indexes 
-- it's all about staying proactive so Monitor the usage of indexes, check missing indexes and make sure the statistics of database are always updated


USE TestDB;

SELECT
	COUNT(*)
FROM transactions