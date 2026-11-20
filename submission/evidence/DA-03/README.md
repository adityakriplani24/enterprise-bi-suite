# DA-03 — Retail and Supply Chain Control Tower: Evidence

This directory is the evidence collection area for the Retail and Supply Chain Control Tower. It documents the local dashboard experience and the execution of the Python analytics pipeline and automated tests.

## Evidence categories

| Evidence item | What it demonstrates | Current status |
|---|---|---|
| Dashboard overview | Dashboard title, prototype notice and KPI cards | Screenshots supplied in the conversation; repository upload pending |
| Supplier performance | What-if analysis and supplier performance table | Screenshots supplied in the conversation; repository upload pending |
| Pipeline execution | Actual output from `python src/pipeline.py` | Awaiting execution capture |
| Automated tests | Actual output from `python -m unittest discover -s tests -v` | Awaiting execution capture |

## Dashboard context

The HTML dashboard is a local browser prototype using simulated sample data. It presents inventory health, supplier reliability, demand signals and a supplier-delay what-if view. It is not a live Apache Superset deployment and does not connect to a production PostgreSQL or Airflow environment.

## Execution context

The Python pipeline and three automated test cases are included in the project source. Their presence does not establish a successful run on a target machine. Runtime evidence should reflect the actual command output, including any errors or environment limitations.

## Evidence integrity

Screenshots should be captured directly from the browser or terminal. Any test status shown must match the actual execution result. Do not present simulated data as production data or describe local components as deployed services.
