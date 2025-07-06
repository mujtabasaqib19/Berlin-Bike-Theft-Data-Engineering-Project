WITH enriched AS (
    SELECT * FROM {{ ref('int_bike_theft_enriched') }}
)

SELECT
    theft_start_date AS date,
    COUNT(*) AS total_thefts,
    SUM(damage_amount_eur) AS total_damage_eur,
    ROUND(AVG(damage_amount_eur), 2) AS avg_damage_per_theft,

    -- 🟦 Breakdown by tiers
    SUM(CASE WHEN damage_tier = 'no damage' THEN 1 ELSE 0 END) AS no_damage_count,
    SUM(CASE WHEN damage_tier = 'low' THEN 1 ELSE 0 END) AS low_damage_count,
    SUM(CASE WHEN damage_tier = 'medium' THEN 1 ELSE 0 END) AS medium_damage_count,
    SUM(CASE WHEN damage_tier = 'high' THEN 1 ELSE 0 END) AS high_damage_count,
    SUM(CASE WHEN damage_tier = 'extreme' THEN 1 ELSE 0 END) AS extreme_damage_count

FROM enriched
GROUP BY theft_start_date
ORDER BY theft_start_date
