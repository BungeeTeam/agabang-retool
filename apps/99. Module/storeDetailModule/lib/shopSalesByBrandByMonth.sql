SELECT year_month, br_cd, SUM(sales_price) as sales_price, sum(tag_price * sales_qty) as tag_price, sum(cost_price * sales_qty) as cost_price
FROM (
  SELECT 
    biz_cd as br_cd,
    date_format(sale_dt, '%Y-%m') as year_month,
    sales_qty,
    sales_price, tag_price, cost_price
  FROM agabang_dw.daily_shop_sales_by_dimension
  WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' 
    AND date_format(DATE '{{ moment().startOf('year').format('YYYY-MM-DD') }}', '%m-%d') <= date_format(sale_dt, '%m-%d') AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ endDate.value }}', '%m-%d')
)
GROUP BY year_month, br_cd
ORDER BY br_cd, year_month