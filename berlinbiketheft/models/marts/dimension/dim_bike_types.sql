-- models/marts/dimensions/dim_bike_types.sql

select
    row_number() over (order by "ART_DES_FAHRRADS") as bike_type_id,
    "ART_DES_FAHRRADS" as bike_type
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
group by "ART_DES_FAHRRADS"
