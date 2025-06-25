with raw_dates as (
    select distinct TO_DATE("ANGELEGT_AM", 'DD.MM.YYYY') as date from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
    union
    select distinct TO_DATE("TATZEIT_ANFANG_DATUM", 'DD.MM.YYYY') from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
    union
    select distinct TO_DATE("TATZEIT_ENDE_DATUM", 'DD.MM.YYYY') from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
)

select
    row_number() over (order by date) as date_id,
    date,
    day(date) as day,
    to_char(date, 'Day') as day_name,
    dayofweek(date) as day_of_week,
    month(date) as month,
    to_char(date, 'Month') as month_name,
    year(date) as year,
    weekofyear(date) as week
from raw_dates
where date is not null