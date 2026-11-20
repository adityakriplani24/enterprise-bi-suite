# Project Evidence

This folder contains genuine project evidence for the DA-01 and DA-03 internship projects. Evidence is added only after the relevant workflow has been opened or executed and the capture has been reviewed.

## Evidence register

| Project | Evidence item | Current status | Source / location |
|---|---|---|---|
| DA-01 | Power BI report screenshots | Pending | Capture from the actual Power BI Desktop report |
| DA-01 | RegionManager and Executive RLS screenshots | Pending | Capture actual View as / Test as role results |
| DA-01 | SQL validation output | Pending | Capture actual SQL Server query results |
| DA-01 | Power BI refresh history | Pending | Capture only if a Power BI Service refresh has been configured and run |
| DA-03 | Local control-tower dashboard screenshots | Pending | Capture the committed `DA-03/dashboard.html` opened in a browser |
| DA-03 | Python pipeline execution output | Pending | Capture actual terminal output after running the pipeline |
| DA-03 | Automated unit-test output | Pending | Capture actual terminal output after running the three tests |
| DA-03 | PostgreSQL / Superset / Airflow evidence | Not supplied | Add only if these services are configured and genuinely run |

## DA-03 capture steps

1. Open `DA-03/dashboard.html` in Chrome or Edge.
2. Capture the full dashboard with the simulated-data notice visible.
3. Capture the KPI and chart sections.
4. Move the supplier-delay what-if slider and capture the changed result.
5. In a terminal opened in the `DA-03` folder, run `python src/pipeline.py` and capture the actual output.
6. Run `python -m unittest discover -s tests -v` and capture the actual output. Do not label the tests as passed unless the command completes successfully.

Save the screenshots in `DA-03/`.

## DA-01 capture steps

1. Open the actual Power BI report in Power BI Desktop.
2. Capture the Executive Overview and relevant regional report pages.
3. If RLS has been configured, use **Modeling → View as** to capture the RegionManager and Executive results.
4. Capture SQL validation output from the actual SQL Server environment.
5. Capture Power BI Service refresh history only if a refresh has genuinely been configured and executed.

Save the screenshots in `DA-01/`.

## Evidence integrity

- Screenshots must show real application output, not mockups or recreated results.
- Do not include passwords, API keys, personal data or confidential client information.
- The DA-03 data is simulated. The local HTML dashboard is a prototype, not a live Superset deployment.
- DA-01 source files and documentation do not, by themselves, prove that a Power BI Service deployment or RLS test has been completed.
