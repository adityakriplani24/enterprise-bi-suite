# DA-03 — Retail and Supply Chain Control Tower

A reproducible prototype using simulated inventory, shipment, supplier and sales feeds.

## Features
- PostgreSQL schema and Superset SQL starter queries.
- Python KPIs: stock-out rate, on-time delivery, supplier lead time and days of inventory.
- Z-score demand anomaly detection (absolute z-score >= 2.5).
- Shipment delay flags (3+ days late).
- Seven-day demand forecast using Prophet when installed; otherwise 28-day moving-average fallback.
- Supplier-delay what-if analysis.
- Hourly Airflow DAG definition and optional Slack/email alert code.
- Local interactive dashboard prototype.

## Run
Python 3.10+:
```bash
python -m venv .venv
# Windows: .venv\\Scripts\\activate
# macOS/Linux: source .venv/bin/activate
pip install -r requirements.txt
python src/pipeline.py
python -m unittest discover -s tests -v
```
Open `dashboard.html` in a browser for the local demo. This is not a live Superset deployment.

## Database and BI
Apply `sql/schema.sql` in PostgreSQL and load the CSV files in `data/`. Run `sql/dashboard_queries.sql` in Superset SQL Lab after configuring the database connection.

## Automation and alerts
The DAG in `airflow/dags/` is scheduled hourly. It requires a configured Airflow environment and project path. Slack/email delivery requires user-provided credentials through environment variables; never commit secrets.

## Assumptions and limitations
All input data is simulated. Days of inventory uses the latest 30 days of average demand. The supplier delay estimate subtracts demand during the delay and does not model open POs. Forecast accuracy has not been validated against a held-out dataset. Live PostgreSQL, Airflow, Superset and alert deployments are not claimed.
