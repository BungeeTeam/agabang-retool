SELECT yr, year_month, br_cd, SUM(sales_price) as sales_price
FROM (
  SELECT 
    toYear(sale_dt) as yr,
    CASE
      WHEN br_cd in ('01', '07', '79') THEN br_cd
      ELSE '기타'
    END as br_cd,
    date_format(sale_dt, '%Y-%m') as year_month,
    sales_qty,
    sales_price
  FROM agabang_dw.daily_shop_sales_by_dimension
  WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' 
    AND date_format(DATE '{{ startDate.value }}', '%m-%d') <= date_format(sale_dt, '%m-%d') AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ endDate.value }}', '%m-%d')
)
GROUP BY yr, year_month, br_cd
ORDER BY br_cd, year_month