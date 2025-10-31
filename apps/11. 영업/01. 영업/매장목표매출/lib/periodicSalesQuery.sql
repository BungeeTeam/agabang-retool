SELECT 
  yr as time_unit,
  ym,
  yr,
  mth as month,
  shop_cd, shop_nm, 
  biz_cd, biz_nm,
  br_cd, br_nm,
  tp_cd, tp_nm, tp_group_nm,
  team_cd, team_nm,
  user_cd, user_nm,
  area_cd, area_nm, 
  onoff_flag, is_flex,
  SUM(rev) / 1000000 as rev, 
  COALESCE(SUM(target_sales), 0) / 1000000 as target_sales
FROM agabang_dw.f_daily_sales_by_shop
WHERE md >= date_format(DATE '{{ dateRange.value.start }}', '%m-%d') AND md <= date_format(DATE '{{ dateRange.value.end }}', '%m-%d')
GROUP BY 
  yr as time_unit,
  ym,
  yr,
  mth,
  shop_cd, shop_nm, 
  biz_cd, biz_nm,
  br_cd, br_nm,
  tp_cd, tp_nm, tp_group_nm,
  team_cd, team_nm,
  user_cd, user_nm,
  area_cd, area_nm, 
  onoff_flag, is_flex