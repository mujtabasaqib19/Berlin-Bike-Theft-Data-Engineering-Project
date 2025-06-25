# 🚲 Berlin Bike Theft Analytics

A complete modern data pipeline to analyze and visualize Berlin bike thefts using **dbt**, **Apache Airflow**, **Snowflake**, and **Power BI**.

---

## 🗂 Project Structure

dbt-dag/
├── .astro/                         # Astro config (optional)
├── dags/
│   ├── __pycache__/
│   ├── biketheft.py               # Airflow DAG that runs dbt
│   └── dbt/
│       └── berlinbiketheft/       # dbt project lives here
│           ├── analyses/
│           ├── logs/
│           ├── macros/
│           ├── models/
│           │   ├── marts/
│           │   │   ├── dimension/
│           │   │   ├── fact/
│           │   │   └── staging/
│           ├── seeds/
│           ├── snapshots/
│           ├── target/
│           ├── tests/
│           ├── dbt_project.yml
│           ├── packages.yml
│           └── README.md
├── .airflowignore


## 🔄 ETL Architecture

java
Copy
Edit
        Raw CSV Files (Bike Thefts)
                   │
                   ▼
      dbt staging models (staging/)
                   │
                   ▼
   dbt marts models (dimension/, fact/, aggregates/)
                   │
                   ▼
       Airflow DAG (biketheft.py)
                   │
                   ▼
     Snowflake Warehouse Tables
                   │
                   ▼
         Power BI Dashboard
yaml
Copy
Edit

---

## 📈 Power BI Insights

![Dashboard Screenshot](./screenshots/powerbi_dashboard.png)

Key Metrics:
- **Total Bike Thefts**: 29.1K  
- **Total Damage Amount**: €37.21M  
- **Most Targeted Time**: Afternoon & Evening  
- **Most Common Day Type**: Weekdays  
- **Most Stolen Types**: Herrenrad, Damenrad  

---

## 🧱 dbt Model Layers

### 📄 `staging/`
- `stg_bike_thefts.sql` – Raw cleaning and type casting

### 🧩 `marts/dimension/`
- `dim_bike_types.sql`
- `dim_dates.sql`, `dim_day_type.sql`, `dim_time_of_day.sql`
- `dim_locations.sql`, `dim_offenses.sql`, ...

### 📊 `marts/fact/`
- `fact_bike_thefts.sql` – Combines all foreign keys + measures

---

## ⚙️ Technologies Used

| Tool         | Role                                  |
|--------------|---------------------------------------|
| dbt          | Data modeling & transformation        |
| Airflow      | DAG orchestration (via Cosmos)        |
| Snowflake    | Cloud data warehouse                  |
| Power BI     | Visualization & dashboarding          |
| Cosmos       | dbt-Aiflow integration layer          |

---

## 🚀 Getting Started

1. **Clone Repo**
   ```bash
   git clone https://github.com/yourusername/berlin-bike-theft-analytics.git
   cd dbt-dag
