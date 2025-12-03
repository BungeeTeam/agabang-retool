SELECT DISTINCT
  biz_cd, biz_nm, 
  br_cd, br_nm, 
  tp_cd, tp_nm,
  team_cd, team_nm,
  user_cd, user_nm,
  area_cd, area_nm
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE YEAR(sale_dt) >= YEAR(today()) AND biz_cd != '' AND user_nm != ''
;