# 9-day plan (11 Nov -> 20 Nov 2026)

The brief estimates 14 days; you have 9 including today. Cut scope, not testing.

| Day | Date | Goal | Done when |
|-----|------|------|-----------|
| 1 | Wed 11 Nov | Install SQL Server + restore AdventureWorksDW; run `sql/01_star_schema_views.sql`; GitHub repo created, first commit | Views return rows; D1 and D3 queries run |
| 2 | Thu 12 Nov | Power Query load, relationships, date table; paste `dax/measures.dax` | Model view matches diagram; M1-M2 pass |
| 3 | Fri 13 Nov | Executive Overview page (KPI cards, YTD vs PY line, region bar, rolling avg) | Page looks finished, screenshot saved |
| 4 | Sat 14 Nov | Sales & Products page + Order Detail drill-through | Drill-through works from 3 visuals |
| 5 | Sun 15 Nov | Finance, Supply Chain, HR pages (lightweight, 3-4 visuals each) | All pages navigable |
| 6 | Mon 16 Nov | RLS roles + all R tests; fix finance-region limitation decision | R1-R6 logged with screenshots |
| 7 | Tue 17 Nov | Publish to Service, refresh schedule, role members, ADF *or* SQL Agent job | Refresh history shows success |
| 8 | Wed 18 Nov | Performance numbers, architecture diagram PNG, README polish, record demo video | Test log complete |
| 9 | Thu 19 Nov | Slides (10 min), reflection, rehearse twice, final commit/tag `v1.0` | Repo clean, link tested from another account |
| Buffer | Fri 20 Nov | Deadline day: submission only | |

**Cut-list if you fall behind (in this order):** HR page -> Supply Chain page -> ADF (use SQL job) -> second drill-through.
**Never cut:** star schema, DAX measures, RLS with test evidence, published report, README.

**Azure note:** If you have no Azure subscription, ADF is not available on the free tier without credits.
Use the SQL Agent job calling `bi.usp_RefreshStaging` (brief allows this) and state it explicitly in the README.
If you do get a student/free credit, a single Copy pipeline (SQL Server -> staging) + schedule trigger is enough.

---

# 10-minute presentation outline

| Min | Slide | Content |
|-----|-------|---------|
| 0-1 | Problem | Multi-region company, 4 siloed data domains, managers must only see their own region |
| 1-3 | Design | Star schema diagram, tech stack, data flow (ADF/SQL job -> SQL Server -> Power BI) |
| 3-6 | Demo | Exec page -> drill-through -> switch "View as" Europe manager -> numbers change |
| 6-7 | Challenges | Finance has no region key; SCD2 employee table; semi-additive inventory; RLS testing |
| 7-9 | Results | Reconciliation = exact match; RLS 6/6 pass; page load ms; refresh time |
| 9-10 | Next steps | Incremental refresh, Fabric/Direct Lake, org-region dimension, alerts |

# Individual reflection template (200-300 words each)
1. What I owned (specific modules/files).
2. The hardest problem and how I solved it.
3. What I would do differently.
4. Skills gained (DAX time intelligence, RLS, dimensional modeling, etc.).
