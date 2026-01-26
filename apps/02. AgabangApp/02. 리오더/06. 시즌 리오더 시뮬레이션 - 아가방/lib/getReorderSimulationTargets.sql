SELECT *
FROM reorder_season_simulation_targets
WHERE BR_CD = '{{ var_brand_code.value }}'
ORDER BY timestamp DESC
-- LIMIT 1;