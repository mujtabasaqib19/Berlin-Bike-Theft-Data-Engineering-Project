-- models/marts/dimensions/dim_locations.sql

select
    row_number() over (order by cast("LOR" as int)) as location_id,
    cast("LOR" as int) as lor_code
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
group by cast("LOR" as int)
