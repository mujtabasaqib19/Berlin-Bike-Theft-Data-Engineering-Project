WITH enriched AS (
    SELECT * FROM {{ ref('int_bike_theft_enriched') }}
)

SELECT
    *  -- all raw + derived columns now included
FROM enriched
