SELECT *
FROM reorder_supplies_simulation_targets
WHERE BR_CD = '{{ var_brand_code.value }}'
ORDER BY timestamp DESC
-- LIMIT 3;