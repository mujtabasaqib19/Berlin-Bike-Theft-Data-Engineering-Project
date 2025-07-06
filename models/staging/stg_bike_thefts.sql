-- models/staging/stg_bike_thefts.sql

SELECT
    -- Timestamps and dates
    CAST(ANGELEGT_AM AS DATE) AS record_created_date,
    CAST(TATZEIT_ANFANG_DATUM AS DATE) AS theft_start_date,
    CAST(TATZEIT_ANFANG_STUNDE AS INT) AS theft_start_hour,
    CAST(TATZEIT_ENDE_DATUM AS DATE) AS theft_end_date,
    CAST(TATZEIT_ENDE_STUNDE AS INT) AS theft_end_hour,

    -- Location and details
    LOR AS location_code,
    SCHADENSHOEHE AS damage_amount_eur,

    -- Raw fields, no business logic
    VERSUCH AS attempted_theft,
    ART_DES_FAHRRADS AS bike_type,
    DELIKT AS theft_category,
    ERFASSUNGSGRUND AS registration_reason,
    TATZEIT_ANFANG_WOCHENTAG AS theft_start_weekday,
    TATZEIT_ENDE_WOCHENTAG AS theft_end_weekday

FROM {{ source('BIKES_THEFT', 'THEFTSDATA') }}
