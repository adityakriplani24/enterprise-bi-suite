# DA-01 — Enterprise Business Intelligence Suite: Evidence

This directory is the evidence collection area for the Enterprise Business Intelligence Suite. It is intended to hold application captures and validation output associated with the SQL Server, Power BI and regional security components.

## Evidence categories

| Evidence item | What it demonstrates | Current status |
|---|---|---|
| Executive overview | Actual Power BI executive report page | Awaiting capture |
| Regional report | Actual regional reporting view | Awaiting capture |
| RegionManager security | Actual region-filtered report result | Awaiting configuration and validation capture |
| Executive security | Actual unrestricted executive role result | Awaiting configuration and validation capture |
| SQL validation | Actual SQL data-quality or reconciliation output | Awaiting execution capture |
| Refresh history | Actual Power BI Service refresh record | Applicable only if Service refresh is configured |

## Project context

The repository includes SQL reporting views, DAX measures, Power Query guidance, an ADF pipeline asset, architecture diagrams, a user guide, a test plan and a presentation. These assets describe the BI solution and its intended validation approach; they do not independently demonstrate a running Power BI report or completed Service deployment.

## Evidence integrity

Only genuine captures from Power BI Desktop, Power BI Service or SQL Server belong in this collection. Results should reflect the environment in which the project was actually configured and tested. No RLS pass, refresh success or performance result is assumed in advance.
