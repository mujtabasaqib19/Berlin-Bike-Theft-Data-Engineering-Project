WITH enriched AS (
    SELECT * FROM {{ ref('int_bike_theft_enriched') }}
)

SELECT
    damage_tier,
    COUNT(*) AS theft_count,
    ROUND(SUM(damage_amount_eur), 2) AS total_damage_eur
FROM enriched
GROUP BY damage_tier
ORDER BY theft_count DESC
