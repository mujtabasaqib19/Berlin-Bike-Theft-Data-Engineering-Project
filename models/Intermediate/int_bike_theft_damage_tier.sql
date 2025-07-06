-- models/intermediate/int_bike_theft_damage_tier.sql

WITH thefts AS (
    SELECT * FROM {{ ref('stg_bike_thefts') }}
)

SELECT
    theft_start_date,
    CASE
        WHEN damage_amount_eur = 0 THEN 'no damage'
        WHEN damage_amount_eur <= 1000 THEN 'low'
        WHEN damage_amount_eur <= 5000 THEN 'medium'
        WHEN damage_amount_eur <= 8000 THEN 'high'
        ELSE 'extreme'
    END AS damage_tier
FROM thefts
