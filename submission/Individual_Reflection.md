# Individual Reflection — Aditya Kriplani

## Project work

I prepared this portfolio around two data analytics projects.

- **DA-01 — Enterprise Business Intelligence Suite:** The project brings together AdventureWorksDW sample data, SQL reporting views, Power Query transformation guidance, DAX measures, a Power BI report, regional security mapping, architecture documentation and a presentation.
- **DA-03 — Retail and Supply Chain Control Tower:** The project demonstrates retail operations analytics using simulated sales, inventory, supplier and shipment data. Its assets include Python analytics code, PostgreSQL schema and queries, a forecasting workflow, an Airflow DAG definition and a local HTML dashboard prototype.

I organised the deliverables into separate project folders and documented the purpose, setup assumptions, evidence and implementation boundaries.

## Learning

Working through these projects helped me connect data preparation, data modelling, analytical calculations and dashboard design to business questions. The work covers SQL reporting structures, Power BI measures and report filtering, regional access-control concepts, Python KPI calculations, demand forecasting and operational performance metrics.

## Challenges and decisions

A key challenge was presenting an end-to-end analytics workflow while keeping the scope reproducible and transparent. I used AdventureWorksDW sample data for DA-01 and simulated operational data for DA-03 rather than production business data. I documented which components are report assets or prototypes and which require environment-specific setup before operational use.

## Evidence and validation

The repository includes the DA-01 Power BI report file and five Power BI Desktop screenshots, two DA-03 dashboard screenshots, source files, project documentation and a presentation.

The DA-01 role screenshots show the selected role context and SecurityMap rows. They do not, by themselves, prove that every report visual has been validated under row-level security or that a Power BI Service deployment is live. DA-03 automated tests are included as test code, but a successful execution result has not been recorded here. The DA-03 dashboard is a local prototype using simulated data, not a live Superset deployment.

## Use of AI assistance

I used ChatGPT as an assistance tool for reviewing wording, structuring documentation and helping prepare parts of the project materials. I reviewed the resulting content and take responsibility for the submitted work. AI assistance is not presented as a substitute for running, validating or deploying the projects.

## Future improvements

I would further validate the DA-01 report and row-level security behaviour in a configured Power BI environment, execute and retain DA-03 test results, and deploy the PostgreSQL, Airflow and BI components in a reproducible environment. I would also evaluate the forecasting approach against held-out data before using it for operational decisions.
