CREATE TABLE IF NOT EXISTS products(sku TEXT PRIMARY KEY,product_name TEXT NOT NULL,category TEXT,unit_cost NUMERIC(12,2),reorder_point INTEGER);
CREATE TABLE IF NOT EXISTS suppliers(supplier_id TEXT PRIMARY KEY,supplier_name TEXT NOT NULL,contract_lead_days INTEGER);
CREATE TABLE IF NOT EXISTS inventory(warehouse_id TEXT,sku TEXT REFERENCES products(sku),on_hand INTEGER,reserved INTEGER DEFAULT 0,updated_at TIMESTAMP,PRIMARY KEY(warehouse_id,sku));
CREATE TABLE IF NOT EXISTS daily_sales(sale_date DATE,sku TEXT REFERENCES products(sku),quantity_sold INTEGER,sales_amount NUMERIC(12,2),PRIMARY KEY(sale_date,sku));
CREATE TABLE IF NOT EXISTS shipments(shipment_id TEXT PRIMARY KEY,supplier_id TEXT REFERENCES suppliers(supplier_id),order_date DATE,expected_delivery_date DATE,actual_delivery_date DATE,units INTEGER,status TEXT);
