SELECT 
  A.*,
  B.cat_nm as category_name,
  concat(year_cd,sesn_cd) as year_season_cd
FROM item_md_info as A 
LEFT OUTER JOIN item_md_category as B
ON A.item_md_category_id = B.id
WHERE cast(A.br_cd as int) = {{ var_brand_code.value }}
order by sty_cd desc