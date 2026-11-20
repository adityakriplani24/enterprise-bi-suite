# Individual Reflection — Aditya Kriplani

## What I worked on

I developed this portfolio around two data analytics use cases:

- **DA-01 — Enterprise Business Intelligence Suite:** I worked on a business intelligence solution using AdventureWorksDW sample data, with SQL reporting views, Power Query transformation guidance, DAX measures, a Power BI report, regional security mapping, architecture documentation and a project presentation.
- **DA-03 — Retail and Supply Chain Control Tower:** I worked on a retail operations analytics prototype using simulated sales, inventory, supplier and shipment data. The project brings together Python analytics, PostgreSQL schema and queries, a forecasting workflow, an Airflow DAG definition and a local HTML dashboard.

I organised the project materials into separate folders and documented the setup, intended workflows, evidence and implementation boundaries.

## What I learned

These projects helped me connect data preparation, data modelling, analytical calculations and dashboard design to business questions. I gained practical exposure to SQL-based reporting structures, Power BI measures and report filtering, regional access-control concepts, Python-based KPI calculations, demand forecasting and operational performance metrics.

## Challenges and decisions

A key challenge was keeping the project scope realistic while documenting how the components fit together. I used sample or simulated datasets so the work could be demonstrated without relying on production business data. I also documented which components are implementation assets or prototypes and which would still need environment setup before being operational.

## Evidence and validation

The repository includes Power BI screenshots for the DA-01 report and role context, dashboard screenshots for DA-03, source files, project documentation and a presentation.

The DA-01 role screenshots show the selected role context and SecurityMap rows; they are not, by themselves, proof that every report visual has been validated under row-level security or that a Power BI Service deployment is live. DA-03 automated tests are included as test code, but a successful execution result has not been recorded in this repository. The DA-03 dashboard is a local prototype using simulated data, not a live Superset deployment.

## Use of AI assistance

I used ChatGPT as an assistance tool for reviewing wording, structuring documentation and helping prepare parts of the project materials. I reviewed the resulting content and take responsibility for the submitted work. AI assistance is not presented as a substitute for running, validating or deploying the projects.

## What I would improve next

I would validate the complete DA-01 report and row-level security behaviour in a configured Power BI environment, execute and retain DA-03 test results, and deploy the PostgreSQL, Airflow and BI components in a reproducible environment. I would also evaluate the forecasting approach against held-out data before using it for operational decisions.
