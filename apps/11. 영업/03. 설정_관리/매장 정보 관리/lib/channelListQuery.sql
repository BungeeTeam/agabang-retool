SELECT DISTINCT
  biz_cd, biz_nm, 
  tp_cd, tp_nm
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE YEAR(sale_dt) >= YEAR(today()) AND biz_cd != ''
ORDER BY biz_cd, tp_nm
;