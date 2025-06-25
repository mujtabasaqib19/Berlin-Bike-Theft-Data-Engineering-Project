# 🚲 Berlin Bike Theft Analytics (dbt + Airflow + Snowflake)

A modern data pipeline to model, orchestrate, and visualize **Berlin bicycle thefts** using dbt, Airflow, Snowflake, and Power BI.

---

## 📁 Project Structure

```bash
dbt-dag/
├── .astro/                         # Astronomer config (optional)
├── dags/
│   ├── __pycache__/
│   ├── biketheft.py               # Airflow DAG using Cosmos
│   └── dbt/
│       └── berlinbiketheft/       # Main dbt project
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

```bash

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
