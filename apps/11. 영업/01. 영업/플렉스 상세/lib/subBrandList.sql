SELECT 
  DISTINCT sub_br_nm, sub_br_cd 
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE sub_br_cd != 'etc'
ORDER BY sub_br_nm
;