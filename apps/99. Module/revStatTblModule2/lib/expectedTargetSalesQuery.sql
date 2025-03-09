SELECT 
  br_cd,
  date_format(year_month, '%y-%m') as ym,
  SUM(target_sales) / 1000000 as target_sales
FROM agabang_dw.yearly_target_sales_by_shop 
WHERE shop_cd = ''
GROUP BY br_cd, year_month