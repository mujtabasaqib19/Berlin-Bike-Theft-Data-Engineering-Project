WITH thefts AS (
    SELECT * FROM {{ ref('stg_bike_thefts') }}
)

SELECT
    theft_start_date,
    theft_end_date,
    theft_start_hour,
    theft_end_hour,

    -- ✅ Start Time of Day
    CASE
        WHEN theft_start_hour BETWEEN 0 AND 6 THEN 'night'
        WHEN theft_start_hour BETWEEN 7 AND 12 THEN 'morning'
        WHEN theft_start_hour BETWEEN 13 AND 18 THEN 'afternoon'
        ELSE 'evening'
    END AS start_time_of_day,

    -- ✅ End Time of Day
    CASE
        WHEN theft_end_hour BETWEEN 0 AND 6 THEN 'night'
        WHEN theft_end_hour BETWEEN 7 AND 12 THEN 'morning'
        WHEN theft_end_hour BETWEEN 13 AND 18 THEN 'afternoon'
        ELSE 'evening'
    END AS end_time_of_day,

    -- ✅ Cross Period Comparison
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
    END AS start_end_time_comparison

FROM thefts
