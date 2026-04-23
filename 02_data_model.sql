-- ========================================
-- DATA MODEL 
-- ========================================

-- This query shows foreign key relationships between tables

SELECT OBJECT_NAME(fk.parent_object_id) AS TableName,
       COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName,
       OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable
FROM sys.foreign_keys fk 
JOIN sys.foreign_key_columns fc
ON fk.object_id = fc.constraint_object_id
ORDER BY TableName, ReferencedTable

