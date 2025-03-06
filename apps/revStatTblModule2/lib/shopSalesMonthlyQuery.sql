SELECT
  year_month as year_month,
  SUM(sales_price) as "판매금액"
FROM (SELECT
    shop_cd,  
    sales_price,
    date_format(sale_dt, '%Y-%m') as year_month
  FROM agabang_dw.daily_shop_sales_by_size
  WHERE shop_cd = '{{ selectedShopInfo.value.shop_cd }}'
) 
GROUP BY year_month
ORDER BY year_month
;