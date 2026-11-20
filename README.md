# Internship Data Analytics Projects

This public repository contains both assigned projects for the Data Analytics specialization.

## DA-01 — Enterprise Business Intelligence Suite for a Multi-Region Company
**Folder:** [DA-01/](DA-01/README.md)

A Power BI-oriented BI solution using an AdventureWorksDW-style star schema, SQL views, DAX measures, Power Query shaping instructions, an Azure Data Factory pipeline example, regional row-level-security design, test plan and user guide.

**Stack:** SQL Server · Power Query · DAX · Power BI · Azure Data Factory / scheduled SQL jobs.

## DA-03 — Retail and Supply Chain Control Tower
**Folder:** [DA-03/](DA-03/README.md)

A simulated-data control-tower prototype for retail inventory, demand, suppliers and shipments. Includes a Python analytics pipeline, KPI definitions, z-score anomaly detection, shipment-delay flags, seven-day forecasting with Prophet/fallback, supplier-delay what-if analysis, PostgreSQL schema, Airflow DAG definition, Superset SQL queries, optional Slack/email alert code and a local interactive HTML demo.

**Stack:** Python · PostgreSQL · Apache Airflow · Apache Superset · Prophet · Slack/email.

## Repository layout
```
DA-01/       Enterprise BI Suite: SQL, DAX, ADF, docs and existing presentation
DA-03/       Supply Chain Control Tower: data, src, sql, airflow, tests, docs, dashboard
submission/  Reflection template and submission guidance
```

## Scope and evidence notes
- DA-03 input files are illustrative simulated data, not company/production data.
- DA-03 `dashboard.html` is a local browser prototype; it is not a deployed Apache Superset service.
- DA-03 Airflow DAG is a workflow definition; an Airflow scheduler has not been deployed by this repository change.
- Slack/email integration requires credentials supplied securely through environment variables. No secrets belong in this repository.
- DA-01 includes implementation artifacts and setup guidance. Do not describe Power BI Service refresh or live RLS as deployed unless independently configured and evidenced.
- Test plans and code are not substitutes for genuine runtime screenshots or a screen recording. Add actual evidence after running the workflows.

## Before final portal submission
1. Review both project READMEs and verify the code in your environment.
2. Run the DA-03 pipeline and unit tests; retain the actual terminal output.
3. Complete DA-01 validation and fill its result placeholders with measured results.
4. Record a genuine demo for each project and add links/screenshots under the relevant docs/evidence folder.
5. Complete `submission/Individual_Reflection_TEMPLATE.md` with your own work and learning.
6. Confirm repository visibility is Public, then submit this repository URL.

