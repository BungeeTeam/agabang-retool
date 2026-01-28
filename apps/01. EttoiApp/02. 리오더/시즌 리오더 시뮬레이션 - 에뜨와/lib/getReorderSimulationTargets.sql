SELECT
  id,
  timestamp,
  user_name,
  br_cd,
  (
    SELECT jsonb_agg(
      jsonb_set(
        jsonb_set(
          item,
          '{reorder_info,"성장률(%)"}',
          to_jsonb(
            CASE
              WHEN (item->'reorder_info'->>'성장률(%)') ~ '^-?\\d+(\\.\\d+)?$' AND (item->'reorder_info'->>'성장률(%)')::numeric >= 100
                THEN (item->'reorder_info'->>'성장률(%)')::numeric - 100
              WHEN (item->'reorder_info'->>'성장률(%)') ~ '^-?\\d+(\\.\\d+)?$'
                THEN (item->'reorder_info'->>'성장률(%)')::numeric
              ELSE 0
            END
          )
        ),
        '{size_reorder_info}',
        COALESCE(
          (
            SELECT jsonb_agg(
              jsonb_set(
                size_item,
                '{growth_rate}',
                to_jsonb(
                  CASE
                    WHEN (size_item->>'growth_rate') ~ '^-?\\d+(\\.\\d+)?$' AND (size_item->>'growth_rate')::numeric >= 100
                      THEN (size_item->>'growth_rate')::numeric - 100
                    WHEN (size_item->>'growth_rate') ~ '^-?\\d+(\\.\\d+)?$'
                      THEN (size_item->>'growth_rate')::numeric
                    ELSE 0
                  END
                )
              )
            )
            FROM jsonb_array_elements(COALESCE(item->'size_reorder_info', '[]'::jsonb)) size_item
          ),
          '[]'::jsonb
        )
      )
    )
    FROM jsonb_array_elements(COALESCE(content::jsonb, '[]'::jsonb)) item
  ) AS content
FROM reorder_season_simulation_targets
WHERE BR_CD = '{{ var_brand_code.value }}'
ORDER BY timestamp DESC;
-- LIMIT 1;