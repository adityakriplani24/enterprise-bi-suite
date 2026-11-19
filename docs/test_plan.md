# Test plan and results log

Fill the **Result** column as you test; screenshots go in `docs/evidence/`.

## 1. Data movement / quality (SQL)
| # | Test | Method | Expected | Result |
|---|------|--------|----------|--------|
| D1 | Orphan rows FactSales -> dims | Query at bottom of `sql/01_star_schema_views.sql` | 0 | |
| D2 | Source vs staging row count | `EXEC bi.usp_RefreshStaging; SELECT * FROM stg.EtlLog` | Status = OK | |
| D3 | Total sales reconciliation | SQL `SUM(SalesAmount)` vs Power BI `[Total Sales]` card (no filters) | Equal to the cent | |
| D4 | Null keys in facts | `WHERE ProductKey IS NULL` etc. | 0 | |

## 2. DAX correctness
| # | Measure | Check | Result |
|---|---------|-------|--------|
| M1 | Margin % | (Sales - Cost)/Sales for one product computed in SQL = visual | |
| M2 | Sales YTD | Dec of a full year YTD = that year's total sales | |
| M3 | YoY % | Hand-calc one month from two SQL totals | |
| M4 | 3M Rolling Avg | Hand-calc one month = avg of that and two prior months | |
| M5 | Division by zero | Filter to a region/month with no sales: no errors, blank shown | |

## 3. Row-level security (the key test)
Role **RegionManager** on table `DimRegion`:
```DAX
VAR _u = USERPRINCIPALNAME ()
RETURN DimRegion[Region] IN SELECTCOLUMNS ( FILTER ( SecurityMap, SecurityMap[Email] = _u ), "r", SecurityMap[Region] )
```
Role **Executive**: no filter expression (sees all).

| # | Test | Expected | Result |
|---|------|----------|--------|
| R1 | Desktop: Modeling -> View as -> RegionManager + "Other user" = mgr.europe@... | Only France/Germany/UK; totals match SQL filtered | |
| R2 | Same for mgr.pacific@... | Only Australia | |
| R3 | View as Executive | All regions | |
| R4 | User not in SecurityMap | Empty report, no error | |
| R5 | Service: add users to roles (Dataset -> Security) then "Test as role" | Same as R1-R3 | |
| R6 | Drill-through page as restricted user | Still filtered | |

**Known limitation to document:** `FactFinance` links by Organization, not sales region, so finance
visuals are not region-filtered. Either (a) show finance only on an Executive-only page (hide via
role-based page navigation / separate report), or (b) add an Organization-to-Region mapping dimension.
State which you chose and why in the presentation.

## 4. Performance
| # | Test | Method | Result |
|---|------|--------|--------|
| P1 | Page load time per report page | Desktop -> Optimize -> Performance Analyzer, record DAX query ms for the 3 slowest visuals | |
| P2 | Model size | DAX Studio / VertiPaq Analyzer, or file size of .pbix | |
| P3 | Refresh duration | Service -> Dataset -> Refresh history | |

## 5. Usability
Have one person who did not build it find: top region, a product's margin, and drill to order detail.
Record time-to-answer. This is cheap and impressive evidence.
