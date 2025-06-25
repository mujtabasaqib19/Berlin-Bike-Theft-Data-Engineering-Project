select distinct
    case
        when dayofweek(to_date(tatzeit_anfang_datum, 'DD.MM.YYYY')) in (1, 2, 3, 4, 5) then 'Weekday'
        when dayofweek(to_date(tatzeit_anfang_datum, 'DD.MM.YYYY')) in (6, 7) then 'Weekend'
    end as day_type,
    dayofweek(to_date(tatzeit_anfang_datum, 'DD.MM.YYYY')) as snowflake_day_of_week,
    row_number() over (order by dayofweek(to_date(tatzeit_anfang_datum, 'DD.MM.YYYY'))) as day_type_id
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
where tatzeit_anfang_datum is not null
