select distinct
    case
        when "ERFASSUNGSGRUND" ilike '%anzeige%' then 'Reported'
        when "ERFASSUNGSGRUND" ilike '%nachtrag%' then 'Update'
        when "ERFASSUNGSGRUND" ilike '%polizeilich%' then 'Police Filed'
        else 'Other'
    end as report_reason_group,
    row_number() over (order by 1) as report_reason_group_id
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE