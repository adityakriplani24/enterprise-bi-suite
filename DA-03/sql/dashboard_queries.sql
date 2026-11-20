-- Inventory coverage
SELECT p.sku,p.product_name,SUM(i.on_hand-i.reserved) AS available_stock,p.reorder_point,
ROUND(SUM(i.on_hand-i.reserved)::numeric/NULLIF(AVG(s.avg_demand),0),1) AS days_of_inventory
FROM products p JOIN inventory i USING(sku)
LEFT JOIN (SELECT sku,AVG(quantity_sold) avg_demand FROM daily_sales WHERE sale_date>=CURRENT_DATE-INTERVAL '30 days' GROUP BY sku)s USING(sku)
GROUP BY p.sku,p.product_name,p.reorder_point;
-- Supplier delivery
SELECT sp.supplier_name,COUNT(*) shipments,
ROUND(100.0*AVG(CASE WHEN sh.actual_delivery_date<=sh.expected_delivery_date THEN 1 ELSE 0 END),1) on_time_pct,
ROUND(AVG(sh.actual_delivery_date-sh.order_date),1) avg_lead_days
FROM shipments sh JOIN suppliers sp USING(supplier_id) GROUP BY sp.supplier_name;
-- Demand trend
SELECT sale_date,sku,SUM(quantity_sold) units_sold FROM daily_sales GROUP BY sale_date,sku ORDER BY sale_date;
