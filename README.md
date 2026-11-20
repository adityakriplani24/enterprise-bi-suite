# Data Analytics Internship Projects

**Individual portfolio by Aditya Kriplani**

A portfolio of two data analytics projects focused on enterprise business intelligence and retail supply chain visibility. The repository brings together data models, analytical logic, reporting assets, automation definitions and project documentation.

## DA-01 — Enterprise Business Intelligence Suite

A multi-region business intelligence solution designed to consolidate sales, finance, HR and supply chain reporting in a Power BI environment, with region-based access control for business users.

**Folder:** [DA-01](DA-01/README.md)

**Technology stack:** SQL Server · Power Query · DAX · Power BI · Azure Data Factory · SQL Server Agent

**Key components**
- SQL Server star-schema views and staging/ETL assets.
- Power Query transformation guidance and DAX measures.
- Power BI semantic model and executive/regional reporting design.
- Region-based row-level security using a security mapping table.
- Data quality, DAX, RLS and performance test documentation.
- Architecture diagrams, user guide and project presentation.

## DA-03 — Retail and Supply Chain Control Tower

A retail operations analytics prototype built around simulated inventory, sales, supplier and shipment data. It brings operational KPIs, demand patterns, shipment delays and supplier performance into a consolidated control-tower view.

**Folder:** [DA-03](DA-03/README.md)

**Technology stack:** Python · PostgreSQL · Apache Airflow · Apache Superset · Prophet · Slack/email

**Key components**
- Python pipeline for inventory, demand, supplier and shipment analytics.
- Operational KPIs including stock-out rate, on-time delivery, supplier lead time and days of inventory.
- Demand anomaly detection and shipment-delay flags.
- Seven-day demand forecasting with Prophet and a moving-average fallback.
- Supplier-delay what-if analysis.
- PostgreSQL schema, Superset SQL starter queries and an hourly Airflow DAG definition.
- Optional Slack/email alert code and a local interactive HTML dashboard prototype.

## Repository structure

```text
DA-01/       Enterprise Business Intelligence Suite
DA-03/       Retail and Supply Chain Control Tower
submission/  Individual reflection and supporting evidence
README.md    Portfolio overview
```

## Implementation notes

- DA-01 uses AdventureWorksDW sample data. Power BI Service refresh, workspace configuration and live row-level security depend on environment-specific setup.
- DA-03 uses simulated data for demonstration and analysis; it does not contain production business data.
- The DA-03 HTML dashboard is a local prototype rather than a deployed Apache Superset service.
- The Airflow DAG provides a workflow definition; an operational scheduler requires a configured Airflow environment.
- Alert delivery requires credentials supplied securely through environment variables.
- Project documentation describes the intended validation approach. Runtime results and deployment status should be interpreted only from actual execution and available evidence.

## Project documentation

Each project folder contains its own README with its architecture, features, repository contents, setup context and implementation limitations. Refer to [DA-01](DA-01/README.md) and [DA-03](DA-03/README.md) for the individual project details.
