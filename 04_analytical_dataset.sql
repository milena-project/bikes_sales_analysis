-- ========================================
-- ANALYTICAL DATASET (VIEW)
-- ========================================

CREATE VIEW sales_dataset AS

SELECT 
    soh.SalesOrderID,
    c.CustomerID,
    ISNULL(c.FirstName, '') + ' ' + ISNULL(c.LastName, '') AS CustomerName,
    a.CountryRegion,
    a.StateProvince,
    p.ProductID,
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    parent.Name AS ParentCategory,
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.LineTotal,
    p.StandardCost,

    CASE 
        WHEN parent.Name = 'Bikes' THEN 1
        ELSE 0
    END AS IsBike,

    CASE 
    WHEN sod.LineTotal > 1000 THEN 1
    ELSE 0
    END AS IsHighValueOrder,

(sod.UnitPrice - p.StandardCost) * sod.OrderQty AS Profit

FROM SalesLT.SalesOrderHeader soh

JOIN SalesLT.Customer c
ON soh.CustomerID = c.CustomerID

JOIN SalesLT.Address a
ON soh.ShipToAddressID = a.AddressID

JOIN SalesLT.SalesOrderDetail sod
ON sod.SalesOrderID = soh.SalesOrderID

JOIN SalesLT.Product p
ON sod.ProductID = p.ProductID

JOIN SalesLT.ProductCategory pc
ON pc.ProductCategoryID = p.ProductCategoryID

JOIN SalesLT.ProductCategory parent
ON pc.ParentProductCategoryID = parent.ProductCategoryID