SELECT brand, item_code, item_name
FROM site_brand_item_scrap
WHERE year_season IS NULL OR category_id IS NULL OR category_id = 0 and item_name not like '%세트%' and item_name not like '%수영복%' and item_name not like '%래쉬가드%' and item_name not like '%포대기%' and item_name not like '%보호대%'