# DA-03 10-minute presentation outline
1. Business problem and impact of stock-outs / late suppliers.
2. Objectives and simulated-data scope.
3. Architecture: CSV feeds → PostgreSQL → Airflow → Python → Superset / alerts.
4. Data model: products, suppliers, inventory, daily sales, shipments.
5. KPI definitions and calculation grain.
6. Z-score demand anomaly and shipment-delay thresholds.
7. Seven-day forecast approach and fallback.
8. Supplier delay what-if calculation and demo.
9. Validation, results and limitations.
10. Next steps: live ERP/WMS feeds, deployed orchestration, forecast backtesting and operational alerting.
