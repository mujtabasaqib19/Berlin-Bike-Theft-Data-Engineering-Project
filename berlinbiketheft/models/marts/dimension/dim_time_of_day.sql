select distinct
    case
        when cast(tatzeit_anfang_stunde as integer) between 6 and 11 then 'Morning'
        when cast(tatzeit_anfang_stunde as integer) between 12 and 17 then 'Afternoon'
        when cast(tatzeit_anfang_stunde as integer) between 18 and 21 then 'Evening'
        else 'Night'
    end as time_of_day,
    row_number() over (order by min(tatzeit_anfang_stunde)) as time_of_day_id
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
where tatzeit_anfang_stunde is not null
group by 1