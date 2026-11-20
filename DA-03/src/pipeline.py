"""DA-03 analytics pipeline. Uses simulated CSV inputs in ../data."""
from pathlib import Path
import json
import numpy as np
import pandas as pd
ROOT=Path(__file__).resolve().parents[1]; DATA=ROOT/"data"; OUT=ROOT/"outputs"; OUT.mkdir(exist_ok=True)
def load():
 return {"products":pd.read_csv(DATA/"products.csv"),"suppliers":pd.read_csv(DATA/"suppliers.csv"),
 "inventory":pd.read_csv(DATA/"inventory.csv"),"sales":pd.read_csv(DATA/"daily_sales.csv",parse_dates=["sale_date"]),
 "shipments":pd.read_csv(DATA/"shipments.csv",parse_dates=["order_date","expected_delivery_date","actual_delivery_date"])}
def calculate(d):
 inv=d["inventory"].merge(d["products"],on="sku"); inv["available"]=(inv.on_hand-inv.reserved).clip(lower=0)
 recent=d["sales"][d["sales"].sale_date>=d["sales"].sale_date.max()-pd.Timedelta(days=29)]
 demand=recent.groupby("sku").quantity_sold.mean().rename("avg_daily_demand")
 k=inv.groupby(["sku","product_name","category","reorder_point"],as_index=False).available.sum().rename(columns={"available":"available_stock"}).merge(demand,on="sku",how="left")
 k["days_of_inventory"]=(k.available_stock/k.avg_daily_demand.replace(0,np.nan)).round(1)
 k["stock_status"]=np.where(k.available_stock<=k.reorder_point,"REORDER",np.where(k.days_of_inventory<7,"LOW COVER","HEALTHY"))
 sh=d["shipments"].copy(); sh["lead_days"]=(sh.actual_delivery_date-sh.order_date).dt.days; sh["on_time"]=sh.actual_delivery_date<=sh.expected_delivery_date
 s=sh.groupby("supplier_id",as_index=False).agg(shipments=("shipment_id","count"),on_time_pct=("on_time",lambda x:round(x.mean()*100,1)),avg_lead_days=("lead_days","mean")).merge(d["suppliers"],on="supplier_id")
 metrics={"stock_out_rate_pct":round((inv.available<=0).mean()*100,2),"on_time_delivery_pct":round(sh.on_time.mean()*100,2),"average_supplier_lead_days":round(sh.lead_days.mean(),2),"skus_reorder":int((k.stock_status=="REORDER").sum()),"skus_low_cover":int((k.stock_status=="LOW COVER").sum())}
 return k,s,metrics
def anomalies(d):
 x=d["sales"].groupby(["sale_date","sku"],as_index=False).quantity_sold.sum()
 stats=x.groupby("sku").quantity_sold.agg(["mean","std"]).reset_index(); x=x.merge(stats,on="sku")
 x["z_score"]=((x.quantity_sold-x["mean"])/x["std"].replace(0,np.nan)).fillna(0)
 x=x[x.z_score.abs()>=2.5].copy(); x["anomaly_type"]=np.where(x.z_score>0,"DEMAND_SPIKE","DEMAND_DROP")
 sh=d["shipments"].copy(); sh["delay_days"]=(sh.actual_delivery_date-sh.expected_delivery_date).dt.days
 return x,sh[sh.delay_days>=3].copy()
def forecast(d,horizon=7):
 rows=[]
 for sku,g in d["sales"].groupby("sku"):
  daily=g.groupby("sale_date").quantity_sold.sum().sort_index()
  try:
   from prophet import Prophet
   f=daily.reset_index(); f.columns=["ds","y"]; m=Prophet(daily_seasonality=True,weekly_seasonality=True); m.fit(f)
   pred=m.predict(m.make_future_dataframe(periods=horizon)).tail(horizon).yhat.clip(lower=0).round().astype(int).tolist(); method="Prophet"
  except Exception:
   pred=[max(0,int(round(daily.tail(28).mean())))]*horizon; method="28-day moving average fallback"
  rows.extend([(sku,i,v,method) for i,v in enumerate(pred,1)])
 return pd.DataFrame(rows,columns=["sku","forecast_day","forecast_units","method"])
def what_if(d,days=7):
 inv=d["inventory"].assign(available=lambda x:(x.on_hand-x.reserved).clip(lower=0)).groupby("sku").available.sum()
 avg=d["sales"][d["sales"].sale_date>=d["sales"].sale_date.max()-pd.Timedelta(days=29)].groupby("sku").quantity_sold.mean()
 return pd.DataFrame([{"sku":sku,"current_available_stock":int(stock),"avg_daily_demand":float(avg.get(sku,0)),"delay_days":days,"projected_stock":max(0,round(stock-float(avg.get(sku,0))*days,1))} for sku,stock in inv.items()])
def run():
 d=load(); k,s,m=calculate(d); a,late=anomalies(d); f=forecast(d); w=what_if(d)
 for name,df in [("inventory_kpis",k),("supplier_kpis",s),("demand_anomalies",a),("shipment_anomalies",late),("demand_forecast",f),("supplier_delay_what_if",w)]: df.to_csv(OUT/(name+".csv"),index=False)
 (OUT/"kpis.json").write_text(json.dumps(m,indent=2)); print(json.dumps(m,indent=2)); return m
if __name__=="__main__": run()
