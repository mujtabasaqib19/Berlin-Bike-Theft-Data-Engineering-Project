import os
from datetime import datetime
from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

# Profile config for Snowflake
profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_default",  # This must match Airflow's connection ID
        profile_args={
            "account": "ogompbg-jc92948",
            "database": "BIKE_THEFT",
            "schema": "THEFTS",
            "warehouse": "COMPUTE_WH",
            "role": "ACCOUNTADMIN"
        },
    ),
)

# dbt executable path
execution_config = ExecutionConfig(
    dbt_executable_path=f"{os.environ.get('AIRFLOW_HOME', '/usr/local/airflow')}/dbt_venv/bin/dbt"
)

# Define the DbtDag
dbt_snowflake_dag = DbtDag(
    dag_id="dbt_bike_theft_dag",
    project_config=ProjectConfig("/usr/local/airflow/dags/dbt/berlinbiketheft"),
    profile_config=profile_config,
    execution_config=execution_config,
    operator_args={"install_deps": True},  # Set to False if you're running dbt deps in Dockerfile
    schedule="@daily",
    start_date=datetime(2023, 9, 10),
    catchup=False,
)
