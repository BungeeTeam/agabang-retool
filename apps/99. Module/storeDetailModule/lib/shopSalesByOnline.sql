SELECT 
  sum(case when sale_gb = '온라인판매' then sales_price else 0 end) as online_sales,
  sum(sales_price) as tot_sales
FROM agabang_dw.daily_shop_sales_by_dimension
WHERE shop_cd = '{{ selectedRow.value.shop_cd }}'
AND sale_dt >= '{{ startDate.value }}'
AND sale_dt <= '{{ endDate.value }}'
;