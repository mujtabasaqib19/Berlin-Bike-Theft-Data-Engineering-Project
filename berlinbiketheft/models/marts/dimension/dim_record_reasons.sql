-- models/marts/dimensions/dim_record_reasons.sql

select
    row_number() over (order by "ERFASSUNGSGRUND") as record_reason_id,
    "ERFASSUNGSGRUND" as record_reason
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
group by "ERFASSUNGSGRUND"
