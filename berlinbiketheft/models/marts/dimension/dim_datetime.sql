-- models/marts/dimension/dim_datetime.sql

with datetimes as (
    select 
        DATEADD('hour', cast("TATZEIT_ANFANG_STUNDE" as int), TO_DATE("TATZEIT_ANFANG_DATUM", 'DD.MM.YYYY')) as datetime
    from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE

    union

    select 
        DATEADD('hour', cast("TATZEIT_ENDE_STUNDE" as int), TO_DATE("TATZEIT_ENDE_DATUM", 'DD.MM.YYYY'))
    from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
)

select
    row_number() over (order by datetime) as datetime_id,
    datetime
from datetimes
where datetime is not null
group by datetime
