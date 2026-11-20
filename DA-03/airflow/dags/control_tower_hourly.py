from datetime import datetime,timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
PROJECT="/opt/airflow/project"
with DAG(dag_id="retail_supply_chain_control_tower_hourly",start_date=datetime(2026,11,1),schedule="0 * * * *",catchup=False,default_args={"owner":"intern","retries":1,"retry_delay":timedelta(minutes=5)},tags=["retail","supply-chain"]) as dag:
 refresh=BashOperator(task_id="refresh_analytics",bash_command=f"cd {PROJECT} && python src/pipeline.py")
 alerts=BashOperator(task_id="send_alerts",bash_command=f"cd {PROJECT} && python src/alerts.py")
 refresh >> alerts
