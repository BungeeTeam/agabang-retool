SELECT DISTINCT
  biz_cd, biz_nm, br_cd, br_nm, sub_br_cd, sub_br_nm
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE YEAR(sale_dt) >= YEAR(today()) AND biz_cd != ''
;