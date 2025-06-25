select distinct
    case
        when "DELIKT" ilike '%diebstahl%' then 'Theft'
        when "DELIKT" ilike '%unterschlag%' then 'Embezzlement'
        when "DELIKT" ilike '%betrug%' then 'Fraud'
        else 'Other'
    end as offense_category,
    row_number() over (order by 1) as offense_category_id
from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE