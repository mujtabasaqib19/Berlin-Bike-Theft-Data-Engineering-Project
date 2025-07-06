WITH thefts AS (
    SELECT * FROM {{ ref('stg_bike_thefts') }}
)

SELECT
    -- 🟩 All raw staging columns
    record_created_date,
    theft_start_date,
    theft_start_hour,
    theft_end_date,
    theft_end_hour,
    location_code,
    damage_amount_eur,
    attempted_theft,
    bike_type,
    theft_category,
    registration_reason,
    theft_start_weekday,
    theft_end_weekday,

    -- 🟦 Start & End Time of Day
    CASE
        WHEN theft_start_hour BETWEEN 0 AND 6 THEN 'night'
        WHEN theft_start_hour BETWEEN 7 AND 12 THEN 'morning'
        WHEN theft_start_hour BETWEEN 13 AND 18 THEN 'afternoon'
        ELSE 'evening'
    END AS start_time_of_day,

    CASE
        WHEN theft_end_hour BETWEEN 0 AND 6 THEN 'night'
        WHEN theft_end_hour BETWEEN 7 AND 12 THEN 'morning'
        WHEN theft_end_hour BETWEEN 13 AND 18 THEN 'afternoon'
        ELSE 'evening'
    END AS end_time_of_day,

    -- 🟦 Cross Period Comparison
    CASE
        WHEN 
            CASE
                WHEN theft_start_hour BETWEEN 0 AND 6 THEN 'night'
                WHEN theft_start_hour BETWEEN 7 AND 12 THEN 'morning'
                WHEN theft_start_hour BETWEEN 13 AND 18 THEN 'afternoon'
                ELSE 'evening'
            END
            = 
            CASE
                WHEN theft_end_hour BETWEEN 0 AND 6 THEN 'night'
                WHEN theft_end_hour BETWEEN 7 AND 12 THEN 'morning'
                WHEN theft_end_hour BETWEEN 13 AND 18 THEN 'afternoon'
                ELSE 'evening'
            END
        THEN 'same period'
        ELSE 'cross period'
    END AS start_end_time_comparison,

    -- 🟦 Start & End Day Categories
    CASE
        WHEN LOWER(theft_start_weekday) IN ('saturday', 'sunday') THEN 'weekend'
        ELSE 'weekday'
    END AS start_day_category,

    CASE
        WHEN LOWER(theft_end_weekday) IN ('saturday', 'sunday') THEN 'weekend'
        ELSE 'weekday'
    END AS end_day_category,

    -- 🟦 Damage Tier
    CASE
        WHEN damage_amount_eur = 0 THEN 'no damage'
        WHEN damage_amount_eur <= 1000 THEN 'low'
        WHEN damage_amount_eur <= 5000 THEN 'medium'
        WHEN damage_amount_eur <= 8000 THEN 'high'
        ELSE 'extreme'
    END AS damage_tier,

    -- 🟦 Theft Severity
    CASE
        WHEN LOWER(registration_reason) LIKE '%schwerer%' THEN 'serious theft'
        WHEN LOWER(registration_reason) LIKE '%einfacher%' THEN 'simple theft'
        ELSE 'unknown'
    END AS theft_severity_category

FROM thefts
