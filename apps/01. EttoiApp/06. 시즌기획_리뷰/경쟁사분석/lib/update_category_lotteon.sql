UPDATE site_brand_item_scrap AS s
SET category_id = subquery.category_id
FROM (
    SELECT
        s.id,
        COALESCE(m.id, 0) AS category_id
    FROM site_brand_item_scrap s
    LEFT JOIN site_brand_category_mapping m
      ON SUBSTRING(TRIM(s.item_code), 5, 2) = ANY(SELECT jsonb_array_elements_text(m.lotteon_category))
      AND m.id != 0 AND s.item_code LIKE 'T%'
    WHERE s.site = 'lotteon' AND s.category_id = 0
) AS subquery
WHERE s.id = subquery.id;