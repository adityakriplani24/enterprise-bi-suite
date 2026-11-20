# Data Dictionary
| Dataset | Grain | Key fields | Purpose |
|---|---|---|---|
| products | One row per SKU | sku | Product category, cost and reorder threshold |
| suppliers | One row per supplier | supplier_id | Supplier and contractual lead time |
| inventory | Warehouse + SKU | warehouse_id, sku | On-hand, reserved and snapshot |
| daily_sales | Date + SKU | sale_date, sku | Daily units and sales amount |
| shipments | One row per shipment | shipment_id | Order, expected and actual delivery dates |

## KPI definitions
- Stock-out rate: zero-available warehouse/SKU rows divided by all warehouse/SKU rows.
- On-time delivery: shipments delivered on or before expected date divided by delivered shipments.
- Supplier lead time: average calendar days from order to actual delivery.
- Days of inventory: available stock divided by average daily sales over the latest 30 days.

Data is simulated. The inventory is a snapshot, not a transaction ledger. What-if estimates subtract demand during the delay and do not account for open inbound orders.
