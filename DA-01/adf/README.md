# Azure Data Factory (optional path)
Needs an Azure subscription (free credit or student plan) and a Self-hosted Integration Runtime if SQL Server is on your laptop.
1. Create Data Factory; create linked services for source (SQL Server) and sink (Azure SQL or the same server).
2. Create datasets `ds_sql_bi_factsales` (source view bi.FactSales) and `ds_sql_stg_factsales` (stg.FactSales).
3. Import `pipeline_copy_factsales.json` (Author -> Pipeline -> ... -> Import from pipeline template or paste JSON).
4. Add a Schedule trigger (daily 05:00 IST). Debug-run once; screenshot the green run into docs/evidence/.
No Azure? Skip this folder and use sql/02_sql_agent_job.sql; say so in the README.
