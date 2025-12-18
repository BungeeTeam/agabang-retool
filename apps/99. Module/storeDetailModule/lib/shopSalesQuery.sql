SELECT
  sale_dt,
  year_month, 
  year_quarter, 
  yr,
  SUM(sales_price) as "판매금액"
FROM (
  SELECT
    shop_cd,  
    sales_price,
    sale_dt,
    date_format(sale_dt, '%Y-%m') as year_month,
    year(sale_dt) as yr,
    CONCAT(toString(year(sale_dt)), '-Q', toString(toQuarter(sale_dt))) AS year_quarter
  FROM agabang_dw.daily_shop_sales_by_dimension
  WHERE shop_cd = '{{ selectedRow.value.shop_cd }}' 
    AND date_format(sale_dt, '%m-%d') <= date_format(DATE '{{ endDate.value }}', '%m-%d') AND YEAR(sale_dt) >= {{ moment(endDate.value).subtract('years',2).year() }}
)
GROUP BY year_month, year_quarter, yr, sale_dt
ORDER BY year_month, sale_dt
;