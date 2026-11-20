/* =====================================================================
   Enterprise BI Suite - Star schema layer over AdventureWorksDW
   Run in: SQL Server, database AdventureWorksDW (2019/2022 sample)
   Pattern: a `bi` schema of views = the semantic contract Power BI reads.
   ===================================================================== */
IF SCHEMA_ID('bi') IS NULL EXEC('CREATE SCHEMA bi');
GO

/* ---------- DIMENSIONS ---------- */
CREATE OR ALTER VIEW bi.DimDate AS
SELECT DateKey, FullDateAlternateKey AS [Date],
       CalendarYear, CalendarQuarter, MonthNumberOfYear AS MonthNumber,
       EnglishMonthName AS MonthName,
       CONCAT(CalendarYear,'-',RIGHT('0'+CAST(MonthNumberOfYear AS varchar(2)),2)) AS YearMonth
FROM dbo.DimDate;
GO

CREATE OR ALTER VIEW bi.DimRegion AS
SELECT SalesTerritoryKey AS RegionKey,
       SalesTerritoryRegion AS Region,
       SalesTerritoryCountry AS Country,
       SalesTerritoryGroup AS RegionGroup
FROM dbo.DimSalesTerritory
WHERE SalesTerritoryKey <> 11;           -- drop the 'NA' placeholder row
GO

CREATE OR ALTER VIEW bi.DimProduct AS
SELECT p.ProductKey, p.EnglishProductName AS Product,
       sc.EnglishProductSubcategoryName AS Subcategory,
       c.EnglishProductCategoryName AS Category,
       p.Color, p.StandardCost, p.ListPrice
FROM dbo.DimProduct p
LEFT JOIN dbo.DimProductSubcategory sc ON sc.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory   c  ON c.ProductCategoryKey   = sc.ProductCategoryKey;
GO

CREATE OR ALTER VIEW bi.DimEmployee AS
SELECT EmployeeKey, CONCAT(FirstName,' ',LastName) AS Employee,
       Title, DepartmentName AS Department, SalesTerritoryKey AS RegionKey,
       HireDate, EndDate, CurrentFlag, BaseRate, VacationHours, SickLeaveHours,
       CASE WHEN CurrentFlag = 1 THEN 'Active' ELSE 'Left' END AS EmploymentStatus
FROM dbo.DimEmployee;
GO

CREATE OR ALTER VIEW bi.DimAccount AS
SELECT AccountKey, AccountDescription AS Account, AccountType
FROM dbo.DimAccount;
GO

CREATE OR ALTER VIEW bi.DimScenario AS
SELECT ScenarioKey, ScenarioName FROM dbo.DimScenario;   -- Actual / Budget / Forecast
GO

/* ---------- FACTS ---------- */
-- Unified sales fact: Internet + Reseller channels
CREATE OR ALTER VIEW bi.FactSales AS
SELECT 'Internet' AS Channel, SalesOrderNumber, SalesOrderLineNumber,
       OrderDateKey, ProductKey, SalesTerritoryKey AS RegionKey,
       CAST(NULL AS int) AS EmployeeKey,
       OrderQuantity, SalesAmount, TotalProductCost, Freight
FROM dbo.FactInternetSales
UNION ALL
SELECT 'Reseller', SalesOrderNumber, SalesOrderLineNumber,
       OrderDateKey, ProductKey, SalesTerritoryKey,
       EmployeeKey,
       OrderQuantity, SalesAmount, TotalProductCost, Freight
FROM dbo.FactResellerSales;
GO

CREATE OR ALTER VIEW bi.FactFinance AS
SELECT DateKey, AccountKey, ScenarioKey, OrganizationKey, Amount
FROM dbo.FactFinance;
GO

CREATE OR ALTER VIEW bi.FactInventory AS
SELECT ProductKey, DateKey, UnitsIn, UnitsOut, UnitsBalance, UnitCost,
       UnitsBalance * UnitCost AS InventoryValue
FROM dbo.FactProductInventory;
GO

CREATE OR ALTER VIEW bi.FactSalesQuota AS
SELECT q.EmployeeKey, q.DateKey, q.CalendarYear, q.CalendarQuarter,
       q.SalesAmountQuota, e.SalesTerritoryKey AS RegionKey
FROM dbo.FactSalesQuota q
JOIN dbo.DimEmployee e ON e.EmployeeKey = q.EmployeeKey;
GO

/* ---------- SECURITY MAP (drives RLS) ---------- */
IF OBJECT_ID('bi.SecurityMap') IS NULL
CREATE TABLE bi.SecurityMap (
    Email  nvarchar(200) NOT NULL,   -- must match the user's Power BI sign-in (UPN)
    Region nvarchar(50)  NOT NULL,   -- must match bi.DimRegion.Region
    CONSTRAINT PK_SecurityMap PRIMARY KEY (Email, Region)
);
GO
-- AdventureWorksDW regions: Northwest, Northeast, Central, Southwest, Southeast, Canada,
-- France, Germany, United Kingdom, Australia. Replace emails with real sign-in UPNs.
-- Executives get full access via a separate Power BI role (see docs/test_plan.md).
MERGE bi.SecurityMap AS t
USING (VALUES
  ('mgr.northamerica@yourtenant.onmicrosoft.com','Northwest'),
  ('mgr.northamerica@yourtenant.onmicrosoft.com','Northeast'),
  ('mgr.northamerica@yourtenant.onmicrosoft.com','Central'),
  ('mgr.northamerica@yourtenant.onmicrosoft.com','Southwest'),
  ('mgr.northamerica@yourtenant.onmicrosoft.com','Southeast'),
  ('mgr.northamerica@yourtenant.onmicrosoft.com','Canada'),
  ('mgr.europe@yourtenant.onmicrosoft.com','France'),
  ('mgr.europe@yourtenant.onmicrosoft.com','Germany'),
  ('mgr.europe@yourtenant.onmicrosoft.com','United Kingdom'),
  ('mgr.pacific@yourtenant.onmicrosoft.com','Australia')
) AS s(Email,Region) ON t.Email=s.Email AND t.Region=s.Region
WHEN NOT MATCHED THEN INSERT (Email,Region) VALUES (s.Email,s.Region);
GO

/* ---------- ETL FALLBACK (if Azure Data Factory is unavailable) ----------
   Stage a snapshot + audit log so you can show "data movement" and row-count checks.
   Schedule via SQL Server Agent: EXEC bi.usp_RefreshStaging; nightly.        */
IF SCHEMA_ID('stg') IS NULL EXEC('CREATE SCHEMA stg');
GO
IF OBJECT_ID('stg.EtlLog') IS NULL
CREATE TABLE stg.EtlLog (
    LogId int IDENTITY PRIMARY KEY, RunAt datetime2 DEFAULT SYSUTCDATETIME(),
    TableName sysname, SourceRows int, TargetRows int, Status varchar(10)
);
GO
CREATE OR ALTER PROCEDURE bi.usp_RefreshStaging AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @src int, @tgt int;

    IF OBJECT_ID('stg.FactSales') IS NOT NULL DROP TABLE stg.FactSales;
    SELECT * INTO stg.FactSales FROM bi.FactSales;

    SELECT @src = (SELECT COUNT(*) FROM dbo.FactInternetSales) + (SELECT COUNT(*) FROM dbo.FactResellerSales);
    SELECT @tgt = COUNT(*) FROM stg.FactSales;

    INSERT stg.EtlLog (TableName, SourceRows, TargetRows, Status)
    VALUES ('FactSales', @src, @tgt, CASE WHEN @src=@tgt THEN 'OK' ELSE 'MISMATCH' END);
END;
GO

/* ---------- DATA QUALITY CHECKS (paste results into test report) ---------- */
-- 1. Orphan fact rows (expect 0 each)
SELECT 'FactSales->DimProduct' AS chk, COUNT(*) AS orphans
FROM bi.FactSales f LEFT JOIN bi.DimProduct p ON p.ProductKey=f.ProductKey WHERE p.ProductKey IS NULL
UNION ALL
SELECT 'FactSales->DimRegion', COUNT(*)
FROM bi.FactSales f LEFT JOIN bi.DimRegion r ON r.RegionKey=f.RegionKey WHERE r.RegionKey IS NULL
UNION ALL
SELECT 'FactSales->DimDate', COUNT(*)
FROM bi.FactSales f LEFT JOIN bi.DimDate d ON d.DateKey=f.OrderDateKey WHERE d.DateKey IS NULL;
-- 2. Reconciliation (must equal the Power BI [Total Sales] card)
SELECT SUM(SalesAmount) AS TotalSales_SQL FROM bi.FactSales;
