SELECT
distinct small_cat, middle_cat, large_cat, item_md_category_id
FROM agabang_dw.dim_style
WHERE br_cd = '07'
and year_cd = '{{ select_season.selectedItem.year_cd }}'
and season_cd = '{{ select_season.selectedItem.sesn_cd }}'