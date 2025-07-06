WITH thefts AS (
    SELECT * FROM {{ ref('stg_bike_thefts') }}
)

SELECT
    theft_start_date,
    registration_reason AS raw_registration_reason,

    -- ✅ Grouping theft severity
    CASE
        WHEN LOWER(registration_reason) LIKE '%schwerer%' THEN 'serious theft'
        WHEN LOWER(registration_reason) LIKE '%einfacher%' THEN 'simple theft'
        ELSE 'unknown'
    END AS theft_severity_category

FROM thefts
