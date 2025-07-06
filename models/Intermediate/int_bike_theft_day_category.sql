WITH thefts AS (
    SELECT * FROM {{ ref('stg_bike_thefts') }}
)

SELECT
    theft_start_date,
    theft_end_date,
    theft_start_weekday,
    theft_end_weekday,

    -- ✅ Start Day Category
    CASE
        WHEN LOWER(theft_start_weekday) IN ('saturday', 'sunday') THEN 'weekend'
        ELSE 'weekday'
    END AS start_day_category,

    -- ✅ End Day Category
    CASE
        WHEN LOWER(theft_end_weekday) IN ('saturday', 'sunday') THEN 'weekend'
        ELSE 'weekday'
    END AS end_day_category

FROM thefts
