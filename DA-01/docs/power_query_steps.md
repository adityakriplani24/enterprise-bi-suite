# Power Query steps (Power BI Desktop)

1. **Get Data → SQL Server** → server + `AdventureWorksDW`. Connection mode: **Import**.
2. Pick only the `bi.*` views (never the raw `dbo` tables). One query per view.
3. Per query:
   - Remove unused columns; set data types (keys = Whole Number, amounts = Fixed decimal, dates = Date).
   - `DimDate`: keep as the single date table; Modeling → *Mark as date table* on `Date`.
   - `DimProduct`: Replace null `Subcategory`/`Category` with `"Unassigned"`; Trim text columns.
   - `FactSales`: Group-by is NOT needed (keep order-line grain). Add no calculated columns - use measures.
   - `DimEmployee`: filter nothing; the `EmploymentStatus` column already separates current rows.
4. Name queries exactly as in `dax/measures.dax` (`FactSales`, `DimDate`, ...), drop the `bi` prefix.
5. Set `SecurityMap` to import, **disable "Include in report refresh" = off only if static**, hide it from report view.
6. Hide all key columns and fact numeric columns (users use measures only).
7. Parameters: create `ServerName` and `DatabaseName` parameters so refresh/gateway config is portable.
