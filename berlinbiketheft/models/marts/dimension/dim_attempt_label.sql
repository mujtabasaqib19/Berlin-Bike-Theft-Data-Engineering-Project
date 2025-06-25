select distinct
    case
        when lower("VERSUCH") = 'ja' then 'Attempted'
        when lower("VERSUCH") = 'nein' then 'Successful'
        else 'Unknown'
    end as attempt_label,
    row_number() over (order by 1) as attempt_label_id
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE