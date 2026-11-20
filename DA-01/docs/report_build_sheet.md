# Report build sheet (Power BI Desktop, ~4 hours of clicking)

Prereq: model loaded, relationships set, measures from `dax/measures.dax` pasted. Theme: View -> Themes -> pick one, use it on all pages. Canvas 1280x720.

## Page 1: Executive Overview
| Visual | Fields |
|--------|--------|
| 5 Card visuals (top row) | Total Sales, Gross Profit, Margin %, Sales YoY Growth %, Orders |
| Line chart | X: DimDate[YearMonth]; Y: Total Sales, Sales 3M Rolling Avg |
| Clustered bar | Y: DimRegion[Region]; X: Total Sales (sort desc) |
| Clustered column | X: DimDate[CalendarYear]; Y: Sales YTD, Sales YTD PY |
| Slicers | DimDate[CalendarYear], DimProduct[Category] |
| Title text box | Use measure [Region Title] (fx on title) |

## Page 2: Sales & Products
Matrix (Category > Subcategory > Product; Total Sales, Margin %, Units Sold), Donut (Channel), Top 10 products bar (Top N filter on Product by Total Sales), Scatter (X Units Sold, Y Margin %, details Product).

## Page 3: Order Detail (drill-through)
Drop DimRegion[Region], DimProduct[Product] and DimDate[YearMonth] into the **Drill through** well. Table: SalesOrderNumber, Product, OrderQuantity, SalesAmount, Gross Profit. A Back button is added automatically.

## Page 4: Finance (Executive only)
Matrix Account x [Actual],[Budget],[Budget Variance %]; column chart Actual vs Budget by CalendarYear. Reminder: not region-filtered.

## Page 5: Supply Chain
Cards: Inventory Units, Inventory Value, Days of Inventory. Line: Inventory Units by YearMonth. Table: Product with Inventory Units.

## Page 6: HR
Cards: Headcount, Avg Base Rate, Avg Vacation Hours. Bar: Headcount by Department. Table: Employee, Title, HireDate.

## RLS
Modeling -> Manage roles:
- Role **RegionManager**, table DimRegion, DAX filter from `docs/test_plan.md`.
- Role **Executive**, no filter.
Then View as -> run R1-R4 and screenshot each to `docs/evidence/`.

## Publish
Home -> Publish -> workspace. Service: dataset Settings -> data source credentials (needs on-premises gateway if SQL Server is local), Scheduled refresh daily, Security -> add members to roles. Screenshot refresh history.

## Demo video (OBS or Win+G, 3-4 min)
Overview -> filter -> drill-through -> View as Europe manager (numbers change) -> Service refresh history.
