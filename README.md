# ServiceNow Ticket Analysis Pipeline

## Overview
This project processes ServiceNow ticket data, transforms it using DBT, and visualizes it in Apache Superset. The pipeline is orchestrated using Apache Airflow.

## Setup Instructions

### Prerequisites
1. Install Python 3.8+.
2. Install Docker (for Airflow and PostgresDB).
3. Install DBT (`pip install dbt-postgres`).
4. Install Apache Superset.

### Steps to Run the Project

1. **Set Up PostgresDB**:
   - Run a PostgresDB instance using Docker:
     ```bash
     docker run --name postgres -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres
     ```
   - Create a database:
     ```bash
     docker exec -it postgres psql -U postgres -c "CREATE DATABASE dbname;"
     ```

2. **Set Up Airflow**:
   - Run Airflow using Docker:
     ```bash
     docker-compose up
     ```
   - Place the `servicenow_pipeline.py` file in the `dags/` folder.

3. **Set Up DBT**:
   - Navigate to the `dbt/` folder and run:
     ```bash
     dbt run
     dbt test
     ```

4. **Set Up Superset**:
   - Run Superset using Docker:
     ```bash
     docker run -d -p 8088:8088 --name superset apache/superset
     ```
   - Connect Superset to your PostgresDB and import the `dashboard.json`.

5. **Run the Pipeline**:
   - Trigger the Airflow DAG to ingest data and run transformations.

