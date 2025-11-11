INSERT INTO site_brand_category_memo 
  ( year_season, category_id, memo)
VALUES ( '{{sel_season.value}}', 
  (SELECT id FROM site_brand_category_mapping WHERE category_name = '{{var_category_info.value}}') , '{{category_memo_textarea.value}}')
ON CONFLICT ( year_season, category_id )
DO UPDATE SET
    memo = EXCLUDED.memo