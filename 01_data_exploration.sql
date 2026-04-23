-- ========================================
-- DATA EXPLORARION
-- ========================================

-- What period do we have sales data from?

SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'SalesLT'
ORDER BY TABLE_NAME

-- What information does each table store?

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'SalesLT'
ORDER BY TABLE_NAME, COLUMN_NAME

-- What tables are linked to each other?

SELECT OBJECT_NAME(fk.parent_object_id) AS TableName,
       COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName,
       OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable
FROM sys.foreign_keys fk 
JOIN sys.foreign_key_columns fc
ON fk.object_id = fc.constraint_object_id
ORDER BY TableName, ReferencedTable

-- How large are the tables (number of records)?

SELECT 'Customer' AS TableName, COUNT(*) AS RowsCount FROM SalesLT.Customer
UNION
SELECT 'SalesOrderHeader', COUNT(*) FROM SalesLT.SalesOrderHeader
UNION
SELECT 'SalesOrderDetail', COUNT(*) FROM SalesLT.SalesOrderDetail
UNION
SELECT 'Product', COUNT(*) FROM SalesLT.Product
ORDER BY TableName

-- Is the data complete and correct?

SELECT *
FROM SalesLT.Customer
WHERE EmailAddress IS NULL

-- What period do we have sales data from?

SELECT
    MIN(OrderDate) AS FirstOrder,
    MAX(OrderDate) AS LastOrder
FROM SalesLT.SalesOrderHeader

-- ========================================
-- DATA EXPLORATION — SUMMARY
-- ========================================

-- Dataset AdventureWorksLT represents a relational e-commerce system
-- with key entities: Customer, SalesOrderHeader, SalesOrderDetail, Product, Address

-- The data follows a transactional structure:
-- Customer → SalesOrderHeader → SalesOrderDetail → Product

-- SalesOrderHeader stores order-level information (customer, order date, total amount)
-- SalesOrderDetail contains product-level details (quantity, unit price, line total)

-- Table sizes differ significantly, reflecting business logic:
-- one order can contain multiple products (1-to-many relationship)

-- Basic data quality checks show no critical missing values in key fields

-- Sales data is limited in time (single or very narrow date range),
-- which restricts time-based analysis such as trends or seasonality

-- Further analysis will focus on:
-- product performance, customer behavior, and revenue distribution