-- models/marts/dimensions/dim_offenses.sql

select
    row_number() over (order by "DELIKT") as offense_id,
    "DELIKT" as offense
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
group by "DELIKT"
