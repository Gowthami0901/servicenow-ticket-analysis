from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta
import pandas as pd
from sqlalchemy import create_engine

# Default arguments
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 10, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'servicenow_pipeline',
    default_args=default_args,
    description='A pipeline to process ServiceNow tickets',
    schedule_interval='@daily',
)

# Task 1: Ingest CSV into PostgresDB
def ingest_csv():
    df = pd.read_csv("servicenow_tickets.csv")
    engine = create_engine("postgresql://username:password@localhost:5432/dbname")
    df.to_sql("servicenow_tickets", engine, if_exists="replace", index=False)

ingest_task = PythonOperator(
    task_id='ingest_csv',
    python_callable=ingest_csv,
    dag=dag,
)

# Task 2: Run DBT models
dbt_run = BashOperator(
    task_id='dbt_run',
    bash_command='dbt run',
    dag=dag,
)

# Task 3: Validate DBT models
dbt_test = BashOperator(
    task_id='dbt_test',
    bash_command='dbt test',
    dag=dag,
)

# Define task dependencies
ingest_task >> dbt_run >> dbt_test