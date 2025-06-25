-- models/staging/stg_bike_thefts.sql

select
  -- 🗓️ Standardized dates
  TO_DATE("ANGELEGT_AM", 'DD.MM.YYYY') as angelegt_am,
  TO_DATE("TATZEIT_ANFANG_DATUM", 'DD.MM.YYYY') as tatzeit_anfang_datum,
  cast("TATZEIT_ANFANG_STUNDE" as int) as tatzeit_anfang_stunde,
  TO_DATE("TATZEIT_ENDE_DATUM", 'DD.MM.YYYY') as tatzeit_ende_datum,
  cast("TATZEIT_ENDE_STUNDE" as int) as tatzeit_ende_stunde,

  -- 📍 Location & Values
  cast("LOR" as int) as lor,
  cast("SCHADENSHOEHE" as int) as damage_amount,

  -- 🚨 Attempted flag (bool)
  case
    when lower("VERSUCH") = 'ja' then true
    when lower("VERSUCH") = 'nein' then false
    else null
  end as is_attempted,

  -- 🏷️ Attempt label (for dashboards)
  case
    when lower("VERSUCH") = 'ja' then 'Attempted'
    when lower("VERSUCH") = 'nein' then 'Successful'
    else 'Unknown'
  end as attempt_label,

  -- 🚲 Bike type and normalized category
  "ART_DES_FAHRRADS" as bike_type,

  case
    when "ART_DES_FAHRRADS" ilike '%e-bike%' then 'E-Bike'
    when "ART_DES_FAHRRADS" ilike '%mountain%' then 'Mountain Bike'
    when "ART_DES_FAHRRADS" ilike '%rennrad%' then 'Road Bike'
    when "ART_DES_FAHRRADS" ilike '%kinder%' then 'Kids Bike'
    when "ART_DES_FAHRRADS" is null or trim("ART_DES_FAHRRADS") = '' then 'Unknown'
    else 'Other'
  end as bike_category,

  -- ⚖️ Offense and grouped category
  "DELIKT" as offense,

  case
    when "DELIKT" ilike '%diebstahl%' then 'Theft'
    when "DELIKT" ilike '%unterschlag%' then 'Embezzlement'
    when "DELIKT" ilike '%betrug%' then 'Fraud'
    else 'Other'
  end as offense_category,

  -- 📝 Reason for logging + group
  "ERFASSUNGSGRUND" as record_reason,

  case
    when "ERFASSUNGSGRUND" ilike '%anzeige%' then 'Reported'
    when "ERFASSUNGSGRUND" ilike '%nachtrag%' then 'Update'
    when "ERFASSUNGSGRUND" ilike '%polizeilich%' then 'Police Filed'
    else 'Other'
  end as report_reason_group

from BIKE_THEFT.THEFTS.FAHRRADDIEBSTAHL_TABLE
