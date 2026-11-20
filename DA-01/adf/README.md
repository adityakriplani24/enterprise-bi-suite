# Azure Data Factory Integration

The Azure Data Factory (ADF) component provides an optional orchestration path for moving enterprise business intelligence data from the SQL Server reporting layer into the staging environment.

## Pipeline overview

The included `pipeline_copy_factsales.json` defines a copy pipeline for the FactSales dataset.

- **Source:** SQL Server reporting view `bi.FactSales`.
- **Destination:** staging table `stg.FactSales`.
- **Pipeline asset:** `pipeline_copy_factsales.json`.
- **Scheduling concept:** daily refresh, with SQL Server Agent available as an alternative.

## Environment requirements

An Azure Data Factory instance and configured linked services are required. When the source SQL Server is hosted on a local machine or private network, an appropriately configured Self-hosted Integration Runtime may be required. The destination can be Azure SQL Database or an accessible SQL Server environment, depending on the deployment design.

## Configuration context

The JSON file is a pipeline definition asset and requires environment-specific linked services, datasets, connectivity and credentials before execution. A successful Azure pipeline run is not implied by the presence of this file.

## Alternative orchestration

For environments without Azure Data Factory, the repository includes `../sql/02_sql_agent_job.sql` as a SQL Server Agent scheduling option. The selected orchestration method depends on the available infrastructure.
