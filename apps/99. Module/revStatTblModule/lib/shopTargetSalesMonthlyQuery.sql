SELECT
  year_month as year_month,
  SUM(target_sales) as "목표매출"
FROM (SELECT
    shop_cd,  
    target_sales,
    date_format(year_month, '%Y-%m') as year_month
  FROM agabang_dw.yearly_target_sales_by_shop
  WHERE shop_cd = '{{ selectedShopInfo.value.shop_cd }}'
) 
GROUP BY year_month
ORDER BY year_month
;