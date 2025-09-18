SELECT 
  -- yr as time_unit,
  -- ym,
  -- yr,
  -- mth as month,
  shop_cd, shop_nm,
  biz_cd, biz_nm,
  -- br_cd, br_nm,
  -- tp_cd, tp_nm,
  -- team_cd, team_nm,
  -- user_cd, user_nm,
  -- area_cd, area_nm, 
  -- onoff_flag, is_flex,
  SUM(rev) as rev
FROM agabang_dw.f_daily_sales_by_shop
WHERE md <= date_format(DATE '{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}', '%m-%d') 
  AND md >= date_format(DATE '{{ moment().startOf('month').format('YYYY-MM-DD') }}', '%m-%d') 
  AND CONCAT(shop_cd, shop_nm) LIKE '%{{ search_text.value }}%'
GROUP BY 
shop_cd, shop_nm,
biz_cd, biz_nm
limit 100